Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFDC3BADA9;
	Thu,  7 May 2026 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158869; cv=none; b=WWZMb4dDPoklxOpniSwLgWfJfrJQxXok2dMvdpMkwX0V1xhajxmUXYvfjLGclQgS5U4O1kcFIMelMLlFvGaWVA+5R2O05E0QuA4ONwKhWwNeBk6jQdUvvuCOGjA1Pk+CI8wq/4QqtVMqoQLi5pNaE8M6kPmV+oMjOe4gHAyiN/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158869; c=relaxed/simple;
	bh=leUnFvFz34yduHhbjTeAn585Ke4Spr5kPB9vhRqARDo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rnrC5uIsYKkkLeH5+9d3kL/OsbgqhrKPyN0ZbX20cabrvPBCOW7P6SqBtp0d2Not7I3BULUh/G1nwVuSuysvurFVzBxu/zxnEjirYxxz2C/lYJjlbMb8CaWFHAQNGwkuQH1sMalBkYdk31aicVrF5S9PcBAwb2kzPZynH9R3QhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lQ0+fDE5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lQ0+fDE5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aCmIFOigrkD0jwl//wwxiKRDqRnHS0891gEta4TqTUA=; b=lQ0+fDE5oOJsJb114ObjoZiI27
	0HImb7p8x67InYxTiW6h+marD25ERG17YRcMYMbsTN/i2EW2Hq43leLU4T/p3iqvk2682diz7j9nH
	k6mly8hsMCh8duRUXUALAauYZVeR7fC9QhiSyJfgsJa4CAEd8bbGk1SemD/8sJGfPXea8oLPrjAEO
	aak8HaXMPtx4r86PN71OOo0RBsJL8bLVrOGP5urrAZmmH7ziK4SwUqirz1mXitEZGrxqu/VPTzKLR
	BF6Oad9WhNiWI7ynOwcDzArDyqNAN61Ihzbejt+vcWfGQUB3/M4u8HZZv6PPPx9cF1VR+hyXTm6oP
	8FN3GODA==;
Received: from [172.31.31.148] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKyLR-00000003YP1-2Wsn;
	Thu, 07 May 2026 13:00:49 +0000
Message-ID: <f0f447dea6c8f2deb7f153f745add15d3ecadd19.camel@infradead.org>
Subject: Re: [PATCH] KVM: x86/xen: bail in IRQ context on PREEMPT_RT in
 kvm_xen_set_evtchn_fast()
From: David Woodhouse <dwmw2@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mauricio Faria de Oliveira <mfo@igalia.com>, Paul Durrant
 <paul@xen.org>,  Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Clark Williams <clrkwllms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>,  kernel-dev@igalia.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-rt-devel@lists.linux.dev, 
 syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Date: Thu, 07 May 2026 14:00:49 +0100
In-Reply-To: <20260507071235.rdb4aGeE@linutronix.de>
References: <20260506-xen-rt-sleep-v1-1-53b6b60a671d@igalia.com>
	 <8e7bc66a7994ca06f164a5d5f7ceb3f07d3a1357.camel@infradead.org>
	 <20260507071235.rdb4aGeE@linutronix.de>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-ios6Th2nDdkxhetVWoQF"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-ios6Th2nDdkxhetVWoQF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-05-07 at 09:12 +0200, Sebastian Andrzej Siewior wrote:
>=20
> So the cited patch does not look bad. That read-trylock should be fine
> on RT (as in I don't see anything wrong with it). What did happen to it?

The read_trylock() may be fine... but does a read_unlock() try to
"re-enable" hardirqs?

[  112.266981] ------------[ cut here ]------------
[  112.266987] DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
[  112.266990] WARNING: kernel/locking/lockdep.c:4404 at lockdep_hardirqs_o=
n_prepare.part.0+0xca/0x140, CPU#139: swapper/139/0
[  112.267010] Modules linked in: binfmt_misc cfg80211 rfkill 8021q garp mr=
p stp llc vfat fat spi_nor pmt_telemetry mtd iTCO_wdt pmt_discovery intel_p=
mc_bxt pmt_class intel_sdsi intel_rapl_msr intel_rapl_common intel_uncore_f=
requency intel_uncore_frequency_common intel_ifs i10nm_edac skx_edac_common=
 nfit libnvdimm ena x86_pkg_temp_thermal intel_powerclamp coretemp rapl int=
el_cstate snd_pcm snd_timer snd intel_uncore soundcore pcspkr dax_hmem isst=
_if_mbox_pci isst_if_mmio isst_if_common intel_vsec spi_intel_pci i2c_i801 =
spi_intel i2c_smbus i2c_ismt nfnetlink lz4hc_compress lz4_compress iaa_cryp=
to nvme nvme_core nvme_keyring nvme_auth pinctrl_emmitsburg wmi qat_4xxx in=
tel_qat idxd crc8 idxd_bus fuse
[  112.267088] CPU: 139 UID: 0 PID: 0 Comm: swapper/139 Not tainted 7.1.0-r=
c2+ #13 PREEMPT_{RT,LAZY}=20
[  112.267096] Hardware name: Amazon EC2 c7i.metal-48xl/Not Specified, BIOS=
 1.0 10/16/2017
[  112.267099] RIP: 0010:lockdep_hardirqs_on_prepare.part.0+0xd1/0x140
[  112.267107] Code: 00 00 00 5b c3 cc cc cc cc e8 eb e5 8b 00 85 c0 74 cf =
8b 15 11 b5 62 02 85 d2 75 c5 48 8d 3d 66 54 64 02 48 c7 c6 40 4f 7e b4 <67=
> 48 0f b9 3a 5b c3 cc cc cc cc e8 bf e5 8b 00 85 c0 74 a3 44 8b
[  112.267112] RSP: 0018:ff60c0a7cf974df8 EFLAGS: 00010046
[  112.267118] RAX: 0000000000000001 RBX: ff251118e4165cf0 RCX: 00000000000=
00001
[  112.267122] RDX: 0000000000000000 RSI: ffffffffb47e4f40 RDI: ffffffffb4f=
cd6a0
[  112.267125] RBP: ff60c0a7cf974e70 R08: 0000000000000001 R09: 00000000000=
00000
[  112.267127] R10: 0000000000000000 R11: 0000000000000001 R12: ff251118e41=
66530
[  112.267130] R13: ff251118e4166548 R14: ff251118e5d82bc0 R15: 00000000000=
00000
[  112.267134] FS:  0000000000000000(0000) GS:ff2511184a123000(0000) knlGS:=
0000000000000000
[  112.267138] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  112.267142] CR2: 0000000000000000 CR3: 000000535ee7c004 CR4: 0000000000f=
73ef0
[  112.267146] PKRU: 55555554
[  112.267148] Call Trace:
[  112.267151]  <IRQ>
[  112.267156]  trace_hardirqs_on+0x18/0x100
[  112.267172]  ? lock_release.part.0+0x1c/0x50
[  112.267179]  _raw_spin_unlock_irq+0x28/0x50
[  112.267193]  rt_read_unlock+0x1a2/0x290
[  112.267202]  kvm_xen_set_evtchn_fast+0x347/0x480
[  112.267217]  ? __lock_release.isra.0+0x59/0x170
[  112.267224]  ? __pfx_xen_timer_callback+0x10/0x10
[  112.267231]  xen_timer_callback+0x8c/0xd0
[  112.267239]  __hrtimer_run_queues+0x86/0x3b0
[  112.267253]  hrtimer_interrupt+0x115/0x240


--=-ios6Th2nDdkxhetVWoQF
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUwNzEzMDA0
OVowLwYJKoZIhvcNAQkEMSIEIEd/3RDkqqNULmP1x6etJiSotkA1pdWdObm8vRAMPPtDMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAOVZI6Olr2Q16
v1qDUngX+z521/BLFbf/8rhjwXBYIAPv8EfbXeoDQbGDG1iJQhPfugxfwixI/BHnRVVV0dAnS4do
k9jWtrbmVerCGzgU/Bx/K1DYYahUNgHfiWknF4qn4CKucCTXlOGQHlgQoITm4hskUTaJtE7PnkiE
Kp5Y/oEI4uLTqbMsrkohLgLw6IInoRWs3xUUjDQOJtihlAGkn3UjYaDJ7QcS8OzuJ+sxU2jri0d8
iRN5DSxK1lOYd/Pq3+XAAoLMA8uM+SEYONQ36kHS1isj+o5rdHMlqsedIY7Twr509Pxoseopfpdg
4jSSa/RBJHnRKluZRo3NJtoc4lGEnD5JkHMDN35jA0BMp2hN2gfI07psyzAkJygh7DiU2faQxcM0
0KYKCEHQvKGP0ltgHAvhJFjMvhwtuafE5vTae6obyUPl0d1KFw4p6Y3Fqh8bu8/0k9R6BPjha4uF
1O4UGhzBgUbiAxbX80IpF2CuJAajt7z6iKfCp+v7x/x7BSX3kpj0Q+kp58bbBSTjc/Pll7I8elzd
CQIVOQTW+/5+/XjZPcHWqSzpNXqJBTBFcdVWmv++POM2/84PECajCXsfbgAH7zD3gDOZICZgNhw9
7Pk3i3Rx9A3ufJFmVUDWSRTF6AyYB+vvbfCJ6JdBSJUQdgJBd+0OlSCa+6GibBgAAAAAAAA=


--=-ios6Th2nDdkxhetVWoQF--
