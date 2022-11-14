const { execSync } = require('child_process');
const https = require('https');
const fs = require('fs');
const path = require('path');

const getPackageInfo = async (name) => {
    const output = execSync(`npm show ${name} dist --json`);
    const info = JSON.parse(output.toString());
    return { name, ...info };
}

const downloadLatestArtifact = async (packageInfo) => {
    // noinspection JSUnresolvedVariable
    const tarBall = packageInfo.tarball;
    const artifact = path.resolve(process.cwd(), 'artifact.tgz');
    const file = fs.createWriteStream(artifact);
    return new Promise((resolve, reject) => {
        const request = https.get(tarBall, (response) => {
            response.pipe(file);
            file.on('finish', () => {
                file.close();
                resolve(packageInfo);
            });
        });
        request.on('error', (err) => {
            fs.unlinkSync(artifact)
            reject(err);
        });
    })
}

const runChecksum = async (packageInfo) => {
    const computed = execSync(`shasum artifact.tgz`).toString();
    // noinspection JSUnresolvedVariable
    const current = `${packageInfo.shasum}  artifact.tgz\n`;
    console.info(computed === current);
    if (computed === current) return packageInfo;
    else throw Error('checksum failed');
}

const updateFormula = async (packageInfo) => {
    const sha256Output = execSync(`shasum -a 256 artifact.tgz`).toString();
    const sha256 = sha256Output.replace('  artifact.tgz\n', '');
    const formula = fs.readFileSync(`${packageInfo.name}.rb.template`).toString();

    // noinspection JSUnresolvedVariable
    const updated = formula
        .replace('${tarball}', packageInfo.tarball)
        .replace('${checksum}', sha256);

    fs.writeFileSync(`${packageInfo.name}.rb`, updated);
}

getPackageInfo('git-devbox')
    .then(downloadLatestArtifact)
    .then(runChecksum)
    .then(updateFormula);

