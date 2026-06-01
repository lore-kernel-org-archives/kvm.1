Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730871E9B37;
	Mon,  1 Jun 2026 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318877; cv=none; b=e0ZJrST3g66Z5VqRwM0HanUli5Mk/UJ/ddzsuweXMDlWqLoSOG+tNg/xQnTTlekZN2SgCxbwyQFDJMEj2DYjmFWMj4pGC9DgksM3yQ6fQdG/nwkJW0i3Z5YlExd9rOFgfygdH9HI3H1av9bVgksPQfEe8QwGh6jsRd0/JWKmaXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318877; c=relaxed/simple;
	bh=AcKiDVD4bTN0xepZrItphep7Rpogq2FTSSY/kW1qRFM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DP1sk7O+U9OpKQFfq8pxCR8l1NjK3XEjIZfA1fpoV3gO9aFRFWSnC3qkugYGuNB1BPz+ne5kbhfTVrKD3QoGyz1mASUg7iax+RNOKPgGNyct2/w1xKFQWT1v1AM3t4AzlwQGKPx7Hfkh1kfkvmtwpj26XIFC28modyWp09kyfAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KL1WaaIV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KL1WaaIV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gq7gF3p4N0XQ84FQ1mKRgxYnjS8GWPR/CoL+bEvcYIE=; b=KL1WaaIVW9qrzeGkWlsDZBUkK2
	B79RE0nysPyrbCdZJNw49Nirl+UJPr9qm29NlQzNgeMa13/3LJSBclV6FEHuwbzAaabdh8YyJT8kP
	W8gyTHFGa02mbHIm3vUmz5wC4FhlqcVDQSifoKVfRR+3N7ZPucJP/R3DtKH/m3mD5MEzNMAL+42dD
	3tniydrZy4WjHPzYKFDzgJMblQkjcbbsiOgHvlgpApPhhyZQJN1x+u5/ldgwgE5EpD13vdwtRKSAG
	njl5+CiC7doB7CFJAEuOWMQOdOCV9StWr71LU4IEXL2HPHUuypqD4wBtkbqVKotgfq4adCsEEevgD
	+aqf7wMg==;
Received: from [2001:8b0:10b:5:a9ac:3853:5e3b:fafd] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU2GR-000000007Sq-3SoO;
	Mon, 01 Jun 2026 13:01:08 +0000
Message-ID: <787aa26cf62dfd361eea8ed19f384fc517892501.camel@infradead.org>
Subject: Re: [PATCH v2 01/20] locking/rt: Use raw_spin_lock_irqsave() in
 __rwbase_read_unlock()
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Paul Durrant <paul@xen.org>, Ingo Molnar
 <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun@kernel.org>,  Waiman Long <longman@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,
 syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,  Carsten Stollmaier
 <stollmc@amazon.com>
Date: Mon, 01 Jun 2026 14:01:07 +0100
In-Reply-To: <14442dbf1e6d758fdd4756f2ed5c8cb2738582fb.camel@infradead.org>
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
	 <CABgObfYJsacrCDHRouLDsEz_QF0EBQd8pu3g-V_gta6Eac2e+w@mail.gmail.com>
	 <14442dbf1e6d758fdd4756f2ed5c8cb2738582fb.camel@infradead.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-RXuF3ky5ixZVwvv5N2ee"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-RXuF3ky5ixZVwvv5N2ee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-01 at 11:52 +0100, David Woodhouse wrote:
> On Sat, 2026-05-30 at 16:40 +0200, Paolo Bonzini wrote:
> > On Sat, May 30, 2026 at 3:04=E2=80=AFPM David Woodhouse <dwmw2@infradea=
d.org> wrote:
> > >=20
> > > On Sat, 2026-05-30 at 12:26 +0200, Paolo Bonzini wrote:
> > > >=20
> > > > Yeah, I think so.
> > > >=20
> > > > The write side needs kvm->srcu so it would have to be yet another S=
RCU.
> > > > I initially thought that sucks for the code that calls kvm_gpc_chec=
k(),
> > > > but maybe not because it simply replaces read_lock/read_unlock.
> > > >=20
> > > > By using a seqcount for the data, SRCU only needs to be synchronize=
d in
> > > > gpc_unmap().=C2=A0 So, something like this:
> > >=20
> > > It isn't just gpc_unmap() which does the invalidation. We also
> > > invalidate from the MMU notifier in gfn_to_pfn_cache_invalidate_start=
()
> > > which would also have to synchronize, wouldn't it?
> >=20
> > You're right, the write_lock_irq() there drains the readers and that
> > is needed because khva is not pinned, only kmap()-ed.
> >=20
> > That is already broken for the OOM case under PREEMPT_RT, where
> > rwlock_t becomes sleepable. But using SRCU would break it on
> > !PREEMPT_RT as well.
>=20
> I don't think 'sleepable' is the problem per se, is it? *Why* does the
> OOM killer use mmu_notifier_invalidate_range_start_nonblock()?
>=20
> Commit 93065ac753e4 ("mm, oom: distinguish blockable mode for mmu
> notifiers") did say:
>=20
> =C2=A0=C2=A0=C2=A0 There are several blockable mmu notifiers which might =
sleep in
> =C2=A0=C2=A0=C2=A0 mmu_notifier_invalidate_range_start and that is a prob=
lem for the
> =C2=A0=C2=A0=C2=A0 oom_reaper because it needs to guarantee a forward pro=
gress so it cannot
> =C2=A0=C2=A0=C2=A0 depend on any sleepable locks.
>=20
> But that was in 2018, when mmap_lock was an rw_semaphore.
>=20
> Is "sleepable" still a problem even when PREEMPT_RT where almost
> *everything* is now strictly sleepable? Wouldn't that mean drivers
> aren't even allowed to take their own spinlocks?

Yeah, this is *already* hosed by PREEMPT_RT's "haha let's make things
sleepable that nobody ever expected to be" approach.

It's hard to trigger as not only do you have to get the KVM process to
OOM, it also has to be *slow* to die. I ended up doing this:

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1278,6 +1278,10 @@ void exit_mmap(struct mm_struct *mm)
        VMA_ITERATOR(vmi, mm, 0);
        struct unmap_desc unmap;
=20
+       if (!strcmp(current->comm, "kvm_oom_test")) {
+               pr_info("exit_mmap: delaying before mmu_notifier_release fo=
r kvm_oom_test\n");
+               schedule_timeout_uninterruptible(3*HZ);
+       }
        /* mm's last user has gone, and its about to be pulled down */
        mmu_notifier_release(mm);
=20
And then we see it even when taking kvm->mn_invalidate_lock:

kvm_mmu_notifier_invalidate_range_start+0xac
0xffffffff8132732c is in kvm_mmu_notifier_invalidate_range_start (arch/x86/=
kvm/../../../virt/kvm/kvm_main.c:745).
740		 * adjustments will be imbalanced.
741		 *
742		 * Pairs with the decrement in range_end().
743		 */
744		spin_lock(&kvm->mn_invalidate_lock);
745		kvm->mn_active_invalidate_count++;
746		if (!mmu_notifier_range_blockable(range))
747			pr_info("KVM: non-blockable invalidate_range_start, non_block_count=
=3D%d\n", current->non_block_count);
748		spin_unlock(&kvm->mn_invalidate_lock);
749=09


[  427.919969] mmap: exit_mmap: delaying before mmu_notifier_release for kv=
m_oom_test
[  429.926972] BUG: sleeping function called from invalid context at kernel=
/locking/spinlock_rt.c:48
[  429.926978] in_atomic(): 0, irqs_disabled(): 0, non_block: 1, pid: 280, =
name: oom_reaper
[  429.926982] preempt_count: 0, expected: 0
[  429.926984] RCU nest depth: 0, expected: 0
[  429.926986] 4 locks held by oom_reaper/280:
[  429.926989]  #0: ffff8a61da779cb0 (&mm->mmap_lock){....}-{3:3}, at: oom_=
reaper+0x150/0x520
[  429.927006]  #1: ffffffffa0934f20 (mmu_notifier_invalidate_range_start){=
....}-{0:0}, at: zap_vma_for_reaping+0xb7/0x1d0
[  429.927019]  #2: ffffffffa0934f78 (srcu){....}-{0:0}, at: __mmu_notifier=
_invalidate_range_start+0xae/0x340
[  429.927029]  #3: ffff8a6240295360 (&kvm->mn_invalidate_lock){....}-{2:2}=
, at: kvm_mmu_notifier_invalidate_range_start+0xac/0x4b0
[  429.927044] CPU: 26 UID: 0 PID: 280 Comm: oom_reaper Tainted: G S       =
 I         7.1.0-rc2+ #2460 PREEMPT_{RT,(lazy)}=20
[  429.927051] Tainted: [S]=3DCPU_OUT_OF_SPEC, [I]=3DFIRMWARE_WORKAROUND
[  429.927053] Hardware name: Intel Corporation S2600CW/S2600CW, BIOS SE5C6=
10.86B.01.01.0008.021120151325 02/11/2015
[  429.927055] Call Trace:
[  429.927058]  <TASK>
[  429.927062]  dump_stack_lvl+0x6e/0xa0
[  429.927074]  __might_resched.cold+0xeb/0x100
[  429.927084]  rt_spin_lock+0x6c/0x1a0
[  429.927092]  ? kvm_mmu_notifier_invalidate_range_start+0xac/0x4b0
[  429.927102]  kvm_mmu_notifier_invalidate_range_start+0xac/0x4b0
[  429.927110]  ? sched_update_numa+0xa0/0x270
[  429.927129]  __mmu_notifier_invalidate_range_start+0x129/0x340
[  429.927138]  ? __pfx_oom_reaper+0x10/0x10
[  429.927144]  zap_vma_for_reaping+0x186/0x1d0
[  429.927150]  ? zap_vma_for_reaping+0xb7/0x1d0
[  429.927155]  ? zap_vma_for_reaping+0xb7/0x1d0
[  429.927176]  __oom_reap_task_mm+0xbf/0x100
[  429.927191]  oom_reaper+0xeb/0x520
[  429.927199]  ? __pfx_autoremove_wake_function+0x10/0x10
[  429.927212]  kthread+0xf5/0x130
[  429.927217]  ? __pfx_kthread+0x10/0x10
[  429.927224]  ret_from_fork+0x286/0x310
[  429.927232]  ? __pfx_kthread+0x10/0x10
[  429.927236]  ret_from_fork_asm+0x1a/0x30
[  429.927257]  </TASK>
[  429.927260] KVM: non-blockable invalidate_range_start, non_block_count=
=3D1

--=-RXuF3ky5ixZVwvv5N2ee
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYwMTEzMDEw
N1owLwYJKoZIhvcNAQkEMSIEILXkFRFsXPmvVa5qH9KRheyS2mv2y4irPiK1CK0Mza1SMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAYe+p+c6MGuxR
Zyq3zPTBSMBZOQORYygeDIbVYeAiI9rGgoFtwecfhMhmv1wGOvpk6mIFlNC8jpYvPSxImFB3gVpX
4gg6PW4bRtCsKq8a8dUINFZ/dR6eO6ilf+OcfyvqPZO1riFeHbuDj1Q9SQ7AwkoWWFOKjpE9Z26G
xgtSm8SrIyw+9I9VHCfLw1wDjQ9SvjwXZKOsMda5Zjcru0w4j1l+4f9VBj/LyfnmJJU479loKg1i
5PqrWyupeltkJBMPhqwmVE//OC8NO02wk7guOMCKg1NEW2AW3lm0dQA3o/1RObqLPXvEtOYVhPSH
YhGaX697b9rHXiQ9RFMPCTad08WUlnShea8x5dxfdFN/zxznwlRdtmRWs89U2M6gNFHTIGwSouDJ
PiN3zlEPNs/mE+LIiSZGAe6dCOn9wyNNF5+YT1cIxmKenjzzBFVLHerG6OMIeEYLnQELqMAirdEq
ok6fDxBo+a3tYOgPKZxsM2h5OnsXD/MvmyAACab1lWJfYLpXFrbpvjRu0/Sn/p9L8Gzy2fXwoPHY
6Fd6JIeKCGdPaD+lC7TnlbBLNfmW5WXZ98wlUtjR+mTOPmwQkb1b4x4BFU/8Ep+q7Zr3GdVr7UaI
yZ6eO1ANafnGrkSiyB1+vmTcQB/ygo6LlHtnklDxHeUsDL+UdmPTG5htL+apPM8AAAAAAAA=


--=-RXuF3ky5ixZVwvv5N2ee--
