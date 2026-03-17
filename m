Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6EA38C2BB;
	Tue, 17 Mar 2026 22:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788376; cv=none; b=N805gyu2EroqbcNulsJ3xnImkXRdxdGuWN6uRSNG0rxcVWOEm9oBNNunS8jOLZp1szXuPEb0lpkpESXlETd5CgZrmamG2ReL5Bdm0kxQrbMVxc5+7e+CmXBCxkKls3GRpBPCmrpm4G+0t+TQrO/FjTPUj4s2GyOXr5MEuyrP4z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788376; c=relaxed/simple;
	bh=qCE4nDoA3Lq/frg4C13xOh7gRsY9a0vILhb4MCXWCWk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gtTZtp01MXCk1LExEBJxYnhRK/RNsdTTC9vltEw1E9yRIOfxo1P+M3bzktByumXtllLXNe9z2wy5f+qSMo6NpUKlRgKmaaswvZm5DlxDU7fv0gUDo686ui9lp6paauyWvCfHQ44f1CqO5k/33Ys3f99C2+KNWbhJhf5ywHG8nX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eqja3wkj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eqja3wkj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dY7JDmMAlFy4gmC6sZRA2rTYIguoIcaLu1S+HG8NJmM=; b=eqja3wkj5b0w+oaLzVY9SbbBfU
	O6aC1LH3cb/SaUC2poWDE0ZcL6xW/jVQtq+LnZIGrIV3+HFvTJfveqB1cpfwB3jjiHV+K5k0bUBhb
	YPwP3xenAyn/2YA15EEIURXd8FllkUTMKu8XWzp3D2e/yVBAe7LWFDb+u1OJpuc1hKXrria16Ujp2
	1ZFSrTovmy6akOgLDoynYJ6WfexJzf6SWFEdQk8Irg3EVMUzBzKpZls/ou0kDCgMKeyhBxX4st2Lg
	Z+fiWQ3CKfG3CgkOcGu1qEIKu5+rgE15mcyRnJLPqpd2eAPkTGW3q/RNnwMIlIYBIMFbyJ6UcrWk6
	fkTGld8w==;
Received: from [172.31.31.148] (helo=u09cd745991455d.lumleys.internal)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2dNg-0000000A496-0Bzl;
	Tue, 17 Mar 2026 22:59:20 +0000
Message-ID: <7012ef111737e07fb8e505aaaf2be63e5580a25c.camel@infradead.org>
Subject: Re: [PATCH v2] KVM: x86: Use gfn_to_pfn_cache for record_steal_time
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Carsten Stollmaier <stollmc@amazon.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 17 Mar 2026 22:59:19 +0000
In-Reply-To: <abNXqMq3wx9Yq94h@google.com>
References: <c73bc1f22fbdbd88efb21cb80eccdd98d2ea531a.camel@infradead.org>
	 <abNXqMq3wx9Yq94h@google.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-bwzclag55PUYAqijPlKh"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-bwzclag55PUYAqijPlKh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-03-12 at 17:17 -0700, Sean Christopherson wrote:
>=20
> I'm pretty sure this is going to make PROVE_LOCKING unhappy due to PREEMP=
T_RT
> making rwlock_t sleepable (when called from kvm_sched_out()).=C2=A0 I've =
been content
> to ignore the kvm_xen_set_evtchn_fast() warning[*] because I can't imagin=
e anyone
> is crazy enough to emulate Xen with an RT kernel, but I do know there are=
 RT users
> that run VMs, and so this path would be more than just a PROVE_LOCKING is=
sue.
>=20
> If we want to push the gpc stuff broadly, we need a solution to that (tho=
ugh I'm
> still not 100% convinced using a gpc here is a net positive).
>=20
> [*] https://lore.kernel.org/all/673f4bbc.050a0220.3c9d61.0174.GAE@google.=
com

I set up a test case, and you're quite right:

[  478.182893] [ BUG: Invalid wait context ]
[  478.182895] 7.0.0-rc3+ #2 Tainted: G           OE     =20
[  478.182896] -----------------------------
[  478.182897] steal_time/5227 is trying to lock:
[  478.182898] ff2c7aa6637b8cf8 (&gpc->lock){++++}-{3:3}, at: kvm_arch_vcpu=
_put+0xe8/0x240 [kvm]
[  478.182982] other info that might help us debug this:
[  478.182982] context-{5:5}
[  478.182983] 3 locks held by steal_time/5227:
[  478.182984]  #0: ff2c7aa6637b80a0 (&vcpu->mutex){+.+.}-{4:4}, at: kvm_vc=
pu_ioctl+0xe4/0x950 [kvm]
[  478.183026]  #1: ff2c7ac4fe0367a0 (&rq->__lock){-...}-{2:2}, at: raw_spi=
n_rq_lock_nested+0x24/0xb0
[  478.183034]  #2: ff2c7aa67e96a4e0 (&kvm->srcu){.+.+}-{0:0}, at: kvm_arch=
_vcpu_put+0x7d/0x240 [kvm]

It appears to be fixable just by making it use read_trylock(). In the
PREEMPT_RT case that appears to go through=C2=A0rt_read_trylock() =E2=86=92
rwbase_read_trylock(), which does an atomic cmpxchg on the reader count
and returns immediately if it can't get it. And, crucially, doesn't
seem to whine about it.

There's absolutely no need for the irqsave in this case; this lock is
never obtained from interrupt context anyway.

I think that just using read_trylock() will work for the
kvm_xen_set_evtchn_fast() case too; will look at that in the morning.

@@ -5244,20 +5244,33 @@ static void kvm_steal_time_set_preempted(struct kvm=
_vcpu *vcpu)
        if (unlikely(current->mm !=3D vcpu->kvm->mm))
                return;
=20
-       read_lock_irqsave(&gpc->lock, flags);
+       /*
+        * Use a trylock as this is called from the scheduler path (via
+        * kvm_sched_out), where rwlock_t is not safe on PREEMPT_RT (it
+        * becomes sleepable).  Setting preempted is best-effort anyway;
+        * the old HVA-based code used copy_to_user_nofault() which could
+        * also silently fail.
+        *
+        * Since we only trylock and bail on failure, there is no risk of
+        * deadlock with an interrupt handler, so no need to disable
+        * interrupts.
+        */
+       if (!read_trylock(&gpc->lock))
+               return;
+
        if (!kvm_gpc_check(gpc, sizeof(*st)))
                goto out_unlock_gpc;
=20


--=-bwzclag55PUYAqijPlKh
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMxNzIyNTkx
OVowLwYJKoZIhvcNAQkEMSIEIE9XIz1r1uo1JETZQK+S2M6dkBWVc0aw1G5tFKu93bTdMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIANKbqkxTPoUDG
zpp/qHV8EUcvTI4U06CXMro6nD1ojz931IC+KnQLpDyGfVWGDus0cMoTtWodWAm7Ky1bLe/n8juG
8QMu7kSwE5Lj2uyICp8k3F9MML2eCC2CtPBANbEipAzqr9gtyyRePkBJwhasP+4JCp2Sz2l8FMJf
iqXu7BjVPxdsHPWKAj214+hVt6ZZL+MH8+jPXQ3O/XuaWujHfoCv3Ck7lJgGWi/mdzW0NtSMulFm
dT5KapjJ3twrSk+oyxBrZ7NZVVgsBVY3X5wbeCsQN2DEjNdPZ3bvVjpXpyFZOgSY5CxUUSePmrQa
V6Yi5tSDZuxLJZGUVUOtJA6wBaGHLf0Bq7gO+nVCZq5YGuItegnaq7dQ2tqNLcmSNOIuUXiLqQyv
vqIZPqhYnHiQAN3kL9bev8pYhHLzRROgJcT6SGZ4lERykoBpJlVj6yiyoMPXKeUAWEKVPEhv2Zdo
1JU/wWo1KIQDbfYrulzqnliaAifMYMzVN4X1SiZ1c6MqJEREJPHYzZ9+48fSnyVvHo4qHsOeB8l1
BmhiBr4UCwfjbBU6o6ZV3Kzw5i9/1yC77t7pxnHc2/Wmlr4C1rJiKSYHFwXM/5Uf7/5fCR/sj+o2
C6wW449524dyU4e62jb+LXc6XDbzklKN/Z2NdGpriSlYyR8Ng9l3vvRTWMU6NdUAAAAAAAA=


--=-bwzclag55PUYAqijPlKh--
