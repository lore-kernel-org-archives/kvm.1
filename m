Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB7B215F7D
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773246503; cv=none; b=RsUdT3hks/+9VmIOWWsZkyk82nYHOMh61huoyulwYod8dV0UJp91lg/uYUwUIxBlD+93KOz17Mjoa3TNcJx9s3q9fjecC15RsMiazR3m8N6LuCA0WPKo9m0ovf8k3/BiPWDuZi1OAZ+/m+YtRODPrUf6MuOKXHM0T6k1+chBBRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773246503; c=relaxed/simple;
	bh=m7KuQJqyCmZevf9CBVaMW8nfcBaSI62z1AweR65O+ls=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JKHHPGDz96/4YHZcIqtQHZ+7/cW0rhn71qCBAeJ9zKK6hW1jbzMheWOA/wKZpngHd3P6JsL68T3E+Qagt9sAPuaxuI0/tCVjEp4Mijpsk04nTlD2emmUwAdW1fjCbxTA85tFppaJjfMb38xLNIG7XVsPsrAXoKxGvy70hcD/nuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qNl7JKOX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qNl7JKOX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0syxfTAzsFv3zBWHnBc+nN7vPyBMC+zctvHBpypnqic=; b=qNl7JKOXbEx2ZdoVULXIIJ2nNt
	q2l77AYjLX3phh0g+GOtBG3k8gZPw4kkyT/CHwn9kdJkTLVe5YHkUoqd6DX0/P+tbd1uOcTAInTla
	UvpCz8UJMOB38hDKdCw3VGktLR3v+HK9CttbXKZLnoTg5hhJbyTeyVwC7a26EvsmL1oV5WFy8+qtL
	htMHVPX+7sBl3pG7eKlDx/hmPHGBm92KtjH4csJV1bYpmBzTgGsf3nGNF5YXpbXVJGidxezUnu/Tl
	QBGUWRHVG5OzABh/tzpEOnh4gfozAiR/OIxEAY28b/ihOsFmoOb2v99qz6Sz72DWip5mYOBO/FzqA
	RX6jfSog==;
Received: from [149.13.74.10] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0MPv-0000000HJgq-48i5;
	Wed, 11 Mar 2026 16:28:16 +0000
Message-ID: <34f9ee431cdfd5e3df6dd5cdbe7214312e3fd75a.camel@infradead.org>
Subject: Re: [EXTERNAL] [PATCH v2 0/9] Upgrade intel vPMU version to 5
From: David Woodhouse <dwmw2@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, "xiong.y.zhang@intel.com"
	 <xiong.y.zhang@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "like.xu.linux@gmail.com"
 <like.xu.linux@gmail.com>, "zhenyu.z.wang@intel.com"
 <zhenyu.z.wang@intel.com>,  "kan.liang@intel.com" <kan.liang@intel.com>,
 "zhiyuan.lv@intel.com" <zhiyuan.lv@intel.com>,  "seanjc@google.com"
 <seanjc@google.com>
Date: Wed, 11 Mar 2026 17:28:14 +0100
In-Reply-To: <81465dc2-6734-4a3a-a0c0-2eefd15866e4@linux.intel.com>
References: <c6590d8d23f4b09be727d8745e2ebfd5a6ab002d.camel@amazon.co.uk>
	 <81465dc2-6734-4a3a-a0c0-2eefd15866e4@linux.intel.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-y1Ma5KFBMfn63eAeGzv+"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-y1Ma5KFBMfn63eAeGzv+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-03-11 at 09:37 +0800, Mi, Dapeng wrote:
> On 3/10/2026 7:56 PM, Woodhouse, David wrote:
> > On Thu, 21 Sep 2023 at 16:29:48 +0800, xiong.y.zhang@intel.com=C2=A0wro=
te:> Intel recent processors have supported Architectural Performance
> > > Monitoring Version 5, while Intel vPMU still keeps on version 2. In o=
rder
> > > to use new PMU features introduced in version 4 and 5, this patchset
> > > upgrades vPMU version to 5.
> > What happened to this series?
>=20
> This implementation base on the legacy perf-based emulated vPMU has been
> dropped. The support for higher PMU verion (5/6) would be re-implemented
> base on the new mediated vPMU framework. Thanks.

Thanks. A bit like this?

https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dshortlog;h=3Drefs/=
heads/pmuv5

David Woodhouse (1):
      KVM: selftests: Add tests for PMU v4 GLOBAL_STATUS_SET and GLOBAL_INU=
SE MSRs

Like Xu (1):
      KVM: x86/pmu: Add Intel PMU supported fixed counters mask

Xiong Zhang (7):
      KVM: x86/pmu: Delay vLBR release to the vcpu next sched-in
      KVM: x86/pmu: Don't release vLBR caused by vPMI
      KVM: x86/pmu: Add Streamlined FREEZE_LBR_ON_PMI for vPMU v4
      KVM: x86/pmu: Add PERF_GLOBAL_STATUS_SET MSR emulation
      KVM: x86/pmu: Add MSR_CORE_PERF_GLOBAL_INUSE emulation
      KVM: x86/pmu: Add fixed counter enumeration for pmu v5
      KVM: x86/pmu: Upgrade pmu version to 5 on intel processor

 arch/x86/include/asm/msr-index.h                   |   5 +
 arch/x86/kvm/cpuid.c                               |   5 +-
 arch/x86/kvm/pmu.c                                 |  14 +-
 arch/x86/kvm/pmu.h                                 |  17 ++-
 arch/x86/kvm/svm/pmu.c                             |   1 +
 arch/x86/kvm/vmx/pmu_intel.c                       | 161 +++++++++++++++++=
++--
 arch/x86/kvm/vmx/pmu_intel.h                       |   9 ++
 arch/x86/kvm/vmx/vmx.c                             |  19 ++-
 arch/x86/kvm/x86.c                                 |   3 +-
 tools/arch/x86/include/asm/msr-index.h             |   6 +
 .../testing/selftests/kvm/x86/pmu_counters_test.c  |  92 ++++++++++++
 11 files changed, 301 insertions(+), 31 deletions(-)


--=-y1Ma5KFBMfn63eAeGzv+
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMxMTE2Mjgx
NFowLwYJKoZIhvcNAQkEMSIEIGslG+beozr7TzbdvqwZyyUhHeveoJ1LK97e258BLbsSMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAzYxcDQg8myVQ
bno5flL5g2KdumW1ixpYgtJ0KIzDRDH2tIMIp+unRf2Rs+1mmCY+AEZScmK98p6V5nsoYskSS1no
9ZG2UJMiIB4GZN4Ybm+6qiSMBg1Y6bmnMhs4uReknZEcKS8mXhFgJLhyLoKowKQE+z62r21kK334
wHL9J4VFY6KXB25jh6itJojH/w0GCGPKolDBvLjt89lSmZTRdGbriZnSBG8LYuMx/uxc9jDjL1um
fHQ81CCd5lkzjGWt7bK0/5Qg1hGmwYvbE+cAik/HyRmqae/8LDQSEXYvrktAoCP+Uj3/h9Sp0TIy
Bhr+g+pmBpjFKvtNXWM8pWnCt3sF5IpsEG8XW+gAl9YgIZfrAeALhBsQBDmwEKpuPqXNtvAGE07K
P8UtBsAirBcxY1eB4q2Y4VX665xNVqdvghj0Rq6lpfWRyp3jLBBZiR+Q4uz7CgDxsgE7+GW5OXw5
yhvxguUATGF6+xNlN/MFfvA9ZqwbZl1+ru/UI0Vcqre0DcmdpgkQAPLuyxCLJYHTJTGxfDBk8WSp
N3D+Ojuomf2cgZ8E0tHoL1BqxQfHPIVg6aDo/7D/m5DohKySjuSLWNw0vSYRHhPBvuv9bWdt9PYv
C5eWdm+0S466SUEqblv2tPcXQYUlaukcXMxuMPoYQcaRRmwxivVDUSyv5ehL7g4AAAAAAAA=


--=-y1Ma5KFBMfn63eAeGzv+--
