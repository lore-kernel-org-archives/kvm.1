Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749476;
	b=Jr5idOa7yCw/p4t5F42lgz3wXqlOmylsCabkQVFndoyg5alCw44oETbshtc2WXig8Vq5
	 jSQi+ryIRB9Lj9J8/LcUU6b+alplpaPk6Z0pAzCAJCZCeUc3BGCLbdOK5rPEXFJf9Eiql
	 w266y0RuDAmKjEdvL39sumwDHYKg6UbxRmqjeSB4ba7th9QDLT7HWlJfxTIX6tWJtP21O
	 5QyVZoSG1hL18LP5zsRo8jdDEh8f9hSeKX7HwGfllpshdeIIMBsVZC84yiSMsZfPqj+pj
	 NsOoZExaj0YfXKQLvw2WuMz2BLwXvkrWrECB7CVWaFxC3JjB0BC3dEMMEzty1qaOtGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749476;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:User-Agent:MIME-Version:
	 X-SRS-Rewrite;
	bh=VQqmcYlAJapxOcjxi3my8DTbfs0n/trPvnokzDPuwZ4=;
	b=RjRW3f8w8+LuYpYIyF+CL6cUidAdflGeee6K6jKpyndI8CstS1wBMotizbFat1ylge7+
	 WwwyduK5c3tzJiVZq+rjpnT6B0gUlgeK5TsicTJL0KgmA+mHoQ2EKFJBq++HQIVLpVonc
	 kYCTNaejSoQPVDzbY1+dfiuS1G5wbNtCKQfXcsNXtZx63qrN+pf2j8v//hMm4a3eBu0ji
	 dlKJFSOFVnr039UdjR6pUhLHvvWWi11RZg9qNqBh9igJu/mNojIUXmQIgxEAgp49b68/s
	 dY8fkR8q1WTWty0n4VQkL0H+UGwJQlkN+pjEBAxab6H05howqZtvS8PfXkdAQ8F2C3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=gTWuHpr3;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F409E606A31B;
	Tue,  3 Nov 2026 23:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F409E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=gTWuHpr3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VQqmcYlAJapxOcjxi3my8DTbfs0n/trPvnokzDPuwZ4=; b=gTWuHpr3Hc75px8MJwyj43zyoj
	Gv2t7eUts6LZN1Xw+DgPDiYR/Hx8s5KpG8/i4hWnic+epd9kaIv95Tx0CgjsC2A1TOWc4MKwNv4tU
	sKyL8PvJ/3LC5NIqsZFNHyCA0r0KsdgUbJ1bKU6jVunAmQVJ6N/qUye2ugGjCNAAk4TTLVjhGGRDi
	ivmuFqeTsrJkIW68Dbqn6RXwyfv2oWbML9WGrU+cs7xXr5FLBukJhfVQKrL5ZF+bMBVEQ3g5PD4c0
	SRdLnjo709zb/EAx+hjzf8Z3Me9eOXp8ySBma1EvX8oTUOfKQwP9hYlADBRBThURsKHKA/4LXQXNc
	5yVLJomw==;
Received: from [205.251.233.53] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOOB3-00000000AmC-1Pwy;
	Tue, 03 Nov 2026 23:44:29 +0000
Message-ID: <e30c88c5977c9a59aa69495e864f91ff63dfece8.camel@infradead.org>
Subject: Re: [BUG REPORT] KVM: x86: Keep kvmclock_offset monotonic across
 same-host pause/resume
From: David Woodhouse <dwmw2@infradead.org>
To: Dongli Zhang <dongli.zhang@oracle.com>, "Chenzhendong (alex)"	
 <alex.chen@huawei.com>, Sean Christopherson <seanjc@google.com>, Paolo
 Bonzini	 <pbonzini@redhat.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>,  "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>
Cc: luolongmin <luolongmin@huawei.com>, "wangyanan (Y)"
 <wangyanan55@huawei.com>
Date: Tue, 03 Nov 2026 15:44:26 -0800
In-Reply-To: <eba55a4f-458e-47bc-be53-e72fcdb03f08@oracle.com>
References: <e99489abf983494d888f04bb0f901e06@huawei.com>
	 <eba55a4f-458e-47bc-be53-e72fcdb03f08@oracle.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-wbPCmRUwLhhjKRfO1onE"
User-Agent: Evolution 3.62.0-0ubuntu1~ppa1~24.04 
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-wbPCmRUwLhhjKRfO1onE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-11-01 at 12:30 -0800, Dongli Zhang wrote:
> + David.

Thanks.

> FYI there were some prior discussions related to this topic.
>=20
> David has a patch at KVM to enhance the KVM API to resolve the issue. It =
is
> still not in mainline.
>=20
> [PATCH v7 31/36] KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for accurate KVM cl=
ock
> migration
> https://lore.kernel.org/all/20260728144954.355376-32-dwmw2@infradead.org
>=20
> I used to try to enhance from QEMU side to avoid clock drift while accoun=
ting
> for downtime.
>=20
> [PATCH 1/1] target/i386/kvm: account blackout downtime for kvm-clock and =
guest TSC
> https://lore.kernel.org/qemu-devel/20251009095831.46297-1-dongli.zhang@or=
acle.com
>=20
> Here is my RCA about forward drift and backward drift from another perspe=
ctive.
>=20
> https://lore.kernel.org/all/935312be-9a86-49fd-8bb4-2c998a68e2df@oracle.c=
om
>=20
>=20
> On Sun, Nov 1, 2026 8:19:14AM -0800, Chenzhendong (alex) wrote:
> > Hi,
> >=20
> > While testing storage snapshots that suspend and resume a VM on the sam=
e
> > host (vm_stop -> snapshot -> vm_start), we observed that the guest
> > CLOCK_MONOTONIC jumps *backward* by the freeze duration after every
> > resume.
> >=20
> > The problem
> > -----------
> >=20
> > On a same-host pause/resume cycle, QEMU saves the kvmclock value at the
> > freeze instant (T1) via KVM_GET_CLOCK in vm_stop, and feeds it back via
> > KVM_SET_CLOCK in vm_start (T2 =3D T1 + freeze_duration).

The whole of this in KVM upstream today is completely insane.

Note that those are completely different clock domains. Your T1 and T2
are CLOCK_REALTIME, which doesn't even run at the same *rate* as the
host's CLOCK_MONOTONIC_RAW which the kvmclock is theoretically bound
to. And if you do it during a leap second, it's doubly hosed because
it's UTC not TAI.

Ignoring the leap seconds, it's almost tolerable to use KVM_SET_CLOCK
with the KVM_CLOCK_REALTIME flag for live *migration*, but it makes
zero sense for live update on the *same* host.

The source of timekeeping is the TSC. The guest's TSC is just an
*offset* (and optional scaling) from the host's TSC. So if you're
running on the same host, the guest *TSC* can be reconstituted with
*exactly* the same relationship to the host TSC as before. Not a single
cycle of difference.

The kvmclock is then advertised to the guest as a mathematical function
of the guest's TSC. There's not much excuse for even a single
nanosecond of difference in that *either*. In fact, even with
KVM_[GS]ET_CLOCK_GUEST in my patch series, there's still a =C2=B11ns
variance across get/set. Fixing that would require a lot *more*
refactoring than I've already done, so probably isn't worth it.

Guests should never be using kvmclock on modern CPUs where the TSC is
reliable, *anyway*.

> > kvm_vm_ioctl_set_clock() recomputes the offset unconditionally:
> >=20
> > =C2=A0=C2=A0=C2=A0 kvmclock_offset =3D data.clock - now_raw_ns
> >=20
> > with now_raw_ns sampled at T2. Since
> >=20
> > =C2=A0=C2=A0=C2=A0 data.clock=C2=A0 =3D now_raw_ns(T1) + old_kvmclock_o=
ffset
> >=20
> > this gives
> >=20
> > =C2=A0=C2=A0=C2=A0 new_offset=C2=A0 =3D old_kvmclock_offset - freeze_du=
ration
> >=20
> > i.e. the offset is pulled back by the freeze duration.

Hm? There's no `freeze_duration` in kvm_vm_ioctl_set_clock(). It looks
like this:

	/*
	 * This pairs with kvm_guest_time_update(): when masterclock
is
	 * in use, we use master_kernel_ns + kvmclock_offset to set
	 * unsigned 'system_time' so if we use get_kvmclock_ns()
(which
	 * is slightly ahead) here we risk going negative on unsigned
	 * 'system_time' when 'data.clock' is very small.
	 */
	if (data.flags & KVM_CLOCK_REALTIME) {
		u64 now_real_ns =3D ktime_get_real_ns();

		/*
		 * Avoid stepping the kvmclock backwards.
		 */
		if (now_real_ns > data.realtime)
			data.clock +=3D now_real_ns - data.realtime;
	}

Does that not already *have* the monotonicity protection that you are
trying to add?

> > The guest computes CLOCK_MONOTONIC from the pvclock page as:
> >=20
> > =C2=A0=C2=A0=C2=A0 CLOCK_MONOTONIC =3D system_time + (rdtsc - tsc_times=
tamp) * mult >> shift
>=20
> CLOCK_MONOTONIC and kvm-clock are different topics.
>=20
> I would suggest here use kvm-clock or PV clock.

Right, don't use CLOCK_MONOTONIC in the guest; use CLOCK_MONOTONIC_RAW.

You can do this with KVM selftests though; perform the save/restore
from the host and then just run some code in the guest which checks for
monotonicity. Didn't my series already add a test which is very similar
to that?=20

--=-wbPCmRUwLhhjKRfO1onE
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCE8Ew
ggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMwMDAwMDBaFw0zNDAz
MTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1xPQ+dgSxbIIrkaru6skAWJYaGFzmv
q4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XRmS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5Z
S64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1Cxy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTb
Z/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK
72a2GEpI8Wpl26G6I1/LMzz/98T+FqjTqxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZA
CcVdCtl4nAacFacmsiArZBfX7AQGL7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8W
mAESbUriIjyuTUf3fJ9oDNCurVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2cs
h2T79v7pC8aUtHBfwNrTR19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61a
CBevQGHNzrbZ3JAMneveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxI
GJiywe9qPhuJSDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtg
v6l+vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEMG
CCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURS
b290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdp
Q2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUA
A4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvCRS2pili3Hy67i8N4N5NU
vw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwEqOOwLLyH02ZQcsfq5p5LrOH9
0JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9YflujuNNvJztjBaHKYZsnNSg+J38o
jYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3x7Nel3A1bwAkalrDMspvTHvey6LfiBks
FIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVrYu8RMIIHAzCCBOugAwIBAgIQAzUotrsybJHx
HTjKOIVdIDANBgkqhkiG9w0BAQsFADBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQs
IEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTEwHhcNMjYwNzE4MDAwMDAwWhcNMjgwMTA0MjM1OTU5WjAeMRwwGgYDVQQDDBNkd213
MkBpbmZyYWRlYWQub3JnMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA2pYux73kdbYX
sWF8f1u6DJP91qcqaZetsyfPkZk0B+MmXmAEv0kVes5n15V2mbDThOnpoPFly0UugQO9JYqLfrtD
tKD5yL58fgrDB9Dw+LQikgrHafl6YSCds5AvUu/8hw2J6noKrcOLJpKlKn9Fl/4IB9Q3JIdLx5aa
EtTqMalIPqHFOlgrJ7s+aua8xbB8YQ9ahqYBXWRJNv3P/2b1DYtdrz1oqZPE3CcB8Pc6Gf2a1Tcm
6TAgtEx7Cf1BFcrsrMz7TWHmGQITieNb2r9UYWSc2Gp+GtYFNJCgT0JJXKUBIauPMKBLteYrL8Fo
ff/uY44dC/mDWjdCP/5x0qelPQjlBvWdHL5zvBTOj06rJ0m3HNI/hnIcDh0Qu2j9reb9rLVcdym6
bWmBM4uDEB8Zv9Ph0KTBFSy1IosyakuD1j1Os30EzjGfbi0EUXIvnOcYbTBAbM5UAzrxEHMhBvoX
Pvnx+OyvjJmc9tWxTX6AcSz+m40esbT17URBeZS18afgieiikm5TynlUYP1LciR3hSgGVzvGXnKO
02VDFR5itGWdRKZ2W5wIShNfWfhSa0D0K5UdIDt5Qc7sjzwK1Yb1sY5Tu0uA5mhIS82q1ov83uxB
sFkriNnhGv/M1NCDVLBiOMsHu73qUM+yKmgKLwF9Hfn9WI25glbAMI4S5r3hYzcCAwEAAaOCAfcw
ggHzMB8GA1UdIwQYMBaAFPebok7Tl8X0NA9DDoGFzpGTMq/5MB0GA1UdDgQWBBRcYhqbcGzn1jrT
JOZaB8O7qllDpzAwBgNVHREEKTAngRNkd213MkBpbmZyYWRlYWQub3JngRBkYXZpZEB3b29kaG91
LnNlMBQGA1UdIAQNMAswCQYHZ4EMAQUBAjAOBgNVHQ8BAf8EBAMCBeAwHQYDVR0lBBYwFAYIKwYB
BQUHAwIGCCsGAQUFBwMEMIGpBgNVHR8EgaEwgZ4wTaBLoEmGR2h0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsME2gS6BJ
hkdodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZT
SEEzODQyMDI0Q0ExLmNybDCBjQYIKwYBBQUHAQEEgYAwfjAkBggrBgEFBQcwAYYYaHR0cDovL29j
c3AuZGlnaWNlcnQuY29tMFYGCCsGAQUFBzAChkpodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20v
RGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0ExLmNydDANBgkqhkiG9w0B
AQsFAAOCAgEAocabrh1cPd5s3vY5rnlBVQSTc7zs2ZWs67dAIltR+05WELrYClVzzUhMs/LOJPlr
EUo45UDDomXq38DxFepaPd9+iNLjXfn33EX/IG44j04lU/oF/Rg9VeQILkYLbCZ/x9wOjNHZc4SN
ydY7Dhvf/sT5aBz88u7D5+azZJ7Qf1U57wYseCH1Mt0nDrtr5y19IJ8D9xJJ33RFL6vfpHZBBAQ8
+3RqkKNxLoV2aFvQhxdhjNLDqTv3LjUIdicwPraN7JkxEu7CV2Lka7eRqJgkWL7SK0YmBjGpRafs
+icP/ON5RCCKTTb6VlX8eTG2sJJfsFhvJNCCt6xexbWzWtIrfP7NvPBvwBB737AyEGBZkS5aNizT
McURJGTv9UKvBh1LF/+tNhYtLvPCN7oecGzhCHht9jcwSkygTo3Y6YlK3QgOu+ncmiBbfeuwlLZ1
LxbYvG6hgNqXv7u6YyADbYajAQJXJ2OQen39pm3Q/AQSyLYG+B8lDglWsM8tYXPlEdrYJcksGK6F
nqIX6Bumn43rBooLJdiZp4WmfWdL2pxe+LxRDjprmqu1WprixDxULSTOKJZoqTlugs6y3Bc+if+s
gHnBBtz9WQ6MtPHkh7zONDAFIKcBmv8OqPQCx0F3Wv3OEybwMpXx0OsKgK8wLldaX1pXcMuyDgTL
Sqs0AV0OHUgwggcDMIIE66ADAgECAhADNSi2uzJskfEdOMo4hV0gMA0GCSqGSIb3DQEBCwUAMGIx
CzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQg
QXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTAeFw0yNjA3MTgwMDAwMDBa
Fw0yODAxMDQyMzU5NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqG
SIb3DQEBAQUAA4ICDwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZe
YAS/SRV6zmfXlXaZsNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2z
kC9S7/yHDYnqegqtw4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qG
pgFdZEk2/c//ZvUNi12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41va
v1RhZJzYan4a1gU0kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0c
vnO8FM6PTqsnSbcc0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PW
PU6zfQTOMZ9uLQRRci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXt
REF5lLXxp+CJ6KKSblPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQr
lR0gO3lBzuyPPArVhvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7Iq
aAovAX0d+f1YjbmCVsAwjhLmveFjNwIDAQABo4IB9zCCAfMwHwYDVR0jBBgwFoAU95uiTtOXxfQ0
D0MOgYXOkZMyr/kwHQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3
bXcyQGluZnJhZGVhZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEC
MA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwgakGA1UdHwSB
oTCBnjBNoEugSYZHaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01J
TUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwTaBLoEmGR2h0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNv
bS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsMIGNBggrBgEF
BQcBAQSBgDB+MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wVgYIKwYBBQUH
MAKGSmh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNB
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
+475puGNxbyToWEjrhHmLRIAAAAAAAA=


--=-wbPCmRUwLhhjKRfO1onE--
