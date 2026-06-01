Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0774939A076;
	Mon,  1 Jun 2026 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780308272; cv=none; b=FHLcr6NHv9d1kqxkpTPxv15ILqSmImURqtEZ+oSssfbVtYmGP8JErmrsiPH4THlQ7aw+WjcNuTxXZi8tOyEluAUsj9L59NkNNGzNW3b60/C9jAarvZxkrfGNBghO8ngSSG+1Wz+zQlZ8bqMhKVe8/4xPdWUg8Fz9bLoZjYRBd80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780308272; c=relaxed/simple;
	bh=zFZVIKNuTtpeloxuk+/OmlmYLH1tV+ScCzdfYuYKaUM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vv7M5AF+kF7heDdKEbBMyh052KV2GCIn8M9JwpUh5SQv9I9460IIPOpW8K3cB+fxGfdAHtBZUZMIirbkTcbLJZXYvEFVbMxJVORvid6ZOul9MBnT+LGvvDItL5ceLe5RH4H/3LywI7b+g3J40Pg3brd0U8nJ45NGW8/0rFzDGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZwW53yAZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZwW53yAZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zFZVIKNuTtpeloxuk+/OmlmYLH1tV+ScCzdfYuYKaUM=; b=ZwW53yAZ7+XS3bEHMZyY8OZ5bA
	UXNxfiGgJSGOUCQWN2uUch4UpZPX6LxIkXo8tlX+fsPIFfQD8iGTqYndh59A/7Aney0UuUzGrViV4
	jJ/T/l/JUDP5WIhyq9McWJENg3PJog69Ti/wplGIuCwPOX0QQtQj9Z7ytUdetWH9BQY3wnyctfMB+
	VziRzGQA2fqKKtQNzAAXKFb+ypV8BOVXEqqWt4ZVKMmtmX/L6rN0IdVwbTldL5z4uUDNz5bgdru3d
	LXi2qj3eAJoPamKy0FpomQaxT2/ZT785I82qujv1TpzKlLbSk9/DdaVe41zsssdaqfZa4rmebv/Hn
	fwjBtj+A==;
Received: from [2001:8b0:10b:5:a9ac:3853:5e3b:fafd] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTzVL-0000000B28f-1whk;
	Mon, 01 Jun 2026 10:04:19 +0000
Message-ID: <e9c30d5c0b746295643262c117eaf49b367aa94e.camel@infradead.org>
Subject: Re: [PATCH v2 01/20] locking/rt: Use raw_spin_lock_irqsave() in
 __rwbase_read_unlock()
From: David Woodhouse <dwmw2@infradead.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>,  Paul Durrant <paul@xen.org>, Ingo Molnar
 <mingo@redhat.com>, Will Deacon <will@kernel.org>,  Boqun Feng
 <boqun@kernel.org>, Waiman Long <longman@redhat.com>, kvm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, 
 syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, Carsten Stollmaier
 <stollmc@amazon.com>
Date: Mon, 01 Jun 2026 11:04:17 +0100
In-Reply-To: <20260601094017.GM3102624@noisy.programming.kicks-ass.net>
References: <20260529165114.748639-1-seanjc@google.com>
	 <20260529165114.748639-2-seanjc@google.com>
	 <20260529193214.GN3493090@noisy.programming.kicks-ass.net>
	 <20260529193437.GB3568911@noisy.programming.kicks-ass.net>
	 <ahnxfACTGeVFbJMk@google.com>
	 <20260529201335.GP3493090@noisy.programming.kicks-ass.net>
	 <20260529203841.GC3568911@noisy.programming.kicks-ass.net>
	 <aho1M7fvK1Qzmiai@google.com>
	 <1c3b224f-2780-4347-b72b-783586a9b0e1@redhat.com>
	 <58d17a623c1c5c9c09bd91baa30510aaf42f899b.camel@infradead.org>
	 <20260601094017.GM3102624@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-MpOg5I86Xrt4LtoDqUcp"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-MpOg5I86Xrt4LtoDqUcp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-01 at 11:40 +0200, Peter Zijlstra wrote:
> On Sat, May 30, 2026 at 01:47:06PM +0100, David Woodhouse wrote:
> > On Sat, 2026-05-30 at 12:26 +0200, Paolo Bonzini wrote:
> > >=20
> > > Yeah, I think so.
> > >=20
> > > The write side needs kvm->srcu so it would have to be yet another SRC=
U.=20
> > > I initially thought that sucks for the code that calls kvm_gpc_check(=
),=20
> > > but maybe not because it simply replaces read_lock/read_unlock.
> > >=20
> > > By using a seqcount for the data, SRCU only needs to be synchronized =
in=20
> > > gpc_unmap().=C2=A0 So, something like this:
> >=20
> > It isn't just gpc_unmap() which does the invalidation. We also
> > invalidate from the MMU notifier in gfn_to_pfn_cache_invalidate_start()
> > which would also have to synchronize, wouldn't it?
>=20
> Ok, so I had a look at what this code actually does, and it appears to
> be a guest frame number to page frame number cache, managed by
> mmu_notifiers.
>=20
> IOW, its some software TLB thing (pre HVM Xen support?)

No, it's for any fast path access to KVM guest memory.

KVM guest physical addresses are translated through two stages.

First through the memslots which convert the GPA to a userspace virtual
address (in the VMM process).

Then through the normal process mm into a host physical address.

The GPC is indeed a software TLB thing used to cache the result of that
two-stage translation, hence being invalidated when *either* the
memslots change (easy), *or* the page is invlidated it the process mm
(more fun).

KVM used to *pin* the latter, which was sad for memory hotunplug and
other reasons, and then *still* managed to screw up the caching. (I
think it would just keep using the old page even if userspace mmap'd
something else over it).

I ripped all that out and replaced it with the gfn-to-pfn-cache we have
now.

It's used to allow a fast path where the *common* case is that the GPC
is already valid. Like interrupt delivery to Xen (HVM) guests which
needs to go into the shared-info page. There's always a slow path
fallback which will revalidate the cache (which might involve bringing
the page back in from swap, etc.). For things like steal time /
runstate information, an invalid cache might lead to it not being
updated when the process is scheduled out, but it'll be refreshed when
scheduled back in again before re-entering the guest.

The GPC also has (well, *had*, but we're looking at reintroducing it=C2=B9)
a mode where the underlying physical address is actually present in the
VMCS and used directly by the CPU, for guest mode. In that mode,
invalidation requires kicking the vCPU *out* of guest mode. That one
requires sleeping and needs handling even for !PREEMPT_RT:

=C2=B9 https://lore.kernel.org/all/20251121111113.456628-3-griffoul@gmail.c=
om/

> Now, mmu_notifier_invalidate_range_start() has a rather explicit
> might_sleep() in, and while there is an
> mmu_notifier_invalidate_range_start_noblock(), that has an error return,
> and it is clearly specified that if that thing returns non-zero, PTEs
> must not be changed.
>=20
> With all that, I don't see why we can't block for srcu_synchronize() in
> gfn_to_pfn_cache_invalidate_start().
>=20
> Now, I've never much looked at mmu_notifiers, but for native, TLBI might
> require sending IPIs to all CPUs, and as such cannot happen in atomic
> sections. I would expect this same to extend to mmu_notifiers. It must
> be possible to sleep in them.
>=20
> What am I missing?

I think it's the OOM path which invokes it in a non-sleepable context?
Hence the may_block argument, and the 'all vCPUs should have been
stopped already, so perform the request without KVM_REQUEST_WAIT and be
sad' comment in the patch I linked above.

The code in virt/kvm/kvm_main.c already tracks 'may_block' for each
call path that gets here; Fred's patch is just passing it in to the GPC
invalidation.

These caches are *mostly* per-vCPU so we don't suffer too much from the
cache contention on the readlocks.=20

--=-MpOg5I86Xrt4LtoDqUcp
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYwMTEwMDQx
N1owLwYJKoZIhvcNAQkEMSIEIKu02M+PERiSuuHMggNjOX77SnSSsGey2Gxlrd6y4WnIMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIARJ/aM4S5GkP6
JcNdQUiJFcXrwi5kl9Nxv5dBwWrYZhCO7bvMLALU9lyiZQT8L7DrTJBP84Y2/x1Y+AoHFygxZm19
fx1vlDU5T8ckfAK9yWMopEgg+LodKi84mpdfyUp53Nh9+ywNMdHlZJ61K/X9MlLjRf2S2drp87uP
CU0avO+urjMdMpyhFjiYmAw8FnjKHSqzWddY6DTRZzi0YiiSEFkSTVxj6JxjUaFiDrA6lccIpwc7
9xQeaif8u/Xrr7g6i7kI2atKIkvrLjUZCN3lQu93VFF1MBFArzA/uMQBvW+WnMjvinggO5/twL8T
4nuULemV+IP/GWvDXsCTan/9hPwVOmS5h7xR7tweKUuTIUyDR20VVmVpjor7gtGF1/ZxkmtgSmgW
z/aFa1I5fABCpDP9IfEfo/XTvpaTbirIfoN9/QTXDCWA2XHUV56srr7iFiv8k3WWsBS42YKVQsLJ
zoTqeqy/cFNhURr8b1NgZbvJU7G2H9HlClr7Hvq/q9g9vXZLb1CAWUgXGrEQPCcXpR6H+JfPoO2C
Xw+xKLNUO979isYysKCu6U2doBwfqbJrYOhwOf+qz2rAjzaj4QUypRo669MAd2HhBkIE0sROI77p
yYGvNanjQKV+z+E5hfeFr2ho62CHT+xpDL2x7YdnaNagaRD3ATZdjBQNGd9wMNkAAAAAAAA=


--=-MpOg5I86Xrt4LtoDqUcp--
