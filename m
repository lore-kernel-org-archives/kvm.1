Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B3134F497
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 04:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787545677; cv=pass; b=tm1TcS+MdQaCVJP5qNv5WbaTko8gBja780Rpj5tI08VkVO4R1ydhV9XAbuU7nLcUoaBJnuS1dbozk1KGxBPKrSiXTdPfrSYC0QAOpHwM5M5E8m44dLh6W69RBR+1cbSYVxom4HqWCvy+6Rb+bRFLU6kIUlEo3stQPCnovUSLrVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787545677; c=relaxed/simple;
	bh=hT0QUt5H542PT0X7fGha+PvX663QHj3aTFMv5sI+ia0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYUoPoRyiS4/tlXErdgblT8fR0ef93gZEkdC80g6SVwXKl3aC5ZniMkTUZ2r/Z8kpAqjytTFOKAzmv1FhEuraDIr6VK456aLCFNdw94XvsSmnwq8Kw1bwPk6iiySgVhio2ALDmyIB0GJXSawlp2DnnNnjOIJxBPyLAtmL8o9S6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sWvMQ0Jh; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sWvMQ0Jh"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90c776f6c13so28335506d6.1
        for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 21:27:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787545674; cv=none;
        d=google.com; s=arc-20260327;
        b=pxnt8xgXMcFJs9EPzWc8MySkjUhmp5eHqE4n5W6NKTCXphe7FdvEiG1s9GkYMusthf
         0xPoUH+B9zdwc/ATfZjpm8aHWd9PEMC2ESzjTzu0WTUUMx4TXxfSxm4+hJIN5aJXkpqH
         Qa2nzLaCx6FSsrtMyzkSvjXVYuliwJGz2FMIqFrPLJ1BVfAzJaAWwHPZbHK7uOjmbOxd
         rrIzet8hvWQAmFp2oU8dGmEWnjH8pFcbqOC3Jpq4J3RtLqOj+TQKHYRGVO/mN7KZUx4H
         YmVP1QjCRDb1k4h/YmNTPmnnGTBsxaa7O45GrI1CsesRyyAs8MZ0X+Y5uOApdLWZzZKG
         9eQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Ow00I9KGY7fZXYsA63TM5zImzlELrKld0vpQu6AI6z8=;
        fh=exj7v3etlpXgs+IL8RftPa75npN/b9w8CfrL5umqxbI=;
        b=B+kVW4Or0x81Q3FvStUURdSwhPu5NAhxIvyyq9b4iER0OUdBvTc6QSa42JrhXFUh39
         JRNd/rTOyzYhgFjR46shgf7hBU1I9+q0CWe3l7KqCkd6Amga2siLPXn+cJvkegLCkH0G
         q2kJH64xaaGUzl/KZs29yPcFrq37vkjaSmsZgWd9+YIk/EMPsroO/48CnILHctH6c2nD
         vDxd6jR3GR51hBy5WB9RQb1xNiefdhjpvgjlCqQwK+JJ8S8XPCfHBYO8ZHPNdmWG1FgW
         D4HI0ZA3tDeFjILJtBijPX+9S3WV81Sf4NAaM9CoiX/XQbUBFXiQks7WH/RewV189HIC
         +0IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787545674; x=1788150474; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ow00I9KGY7fZXYsA63TM5zImzlELrKld0vpQu6AI6z8=;
        b=sWvMQ0JhKAl7PEAzbZVfdmGaQC/eHGrEeTKPy5qSArDZFrWYs459ZfpYCEiMtE2h+C
         9Iys7aVjwaUnTKTp9uMyqlf6Bk3H93Ve1uXCp4ISMf/kWzWylkd50XwqqkGk3IYg3mRL
         Lq5v59z+NgDdQUz7SFU6ZHUoSLhrDpOVI/1KjRfQQpBmWhERUXDNxMWcczmYoHBntTdU
         mv3JsOn3NVfaNMzaWfvYKPHmF6XhqoQEA+JfnavY88tw6IEDExW7wVa1+TeVK3be3Syr
         Ji/vtMRPs9sgl6M5o8Qb0EgHgQ18AuF+QiLzuICyzsErewIh5ndVoi9SibWHd3VHxDGZ
         /KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787545674; x=1788150474;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ow00I9KGY7fZXYsA63TM5zImzlELrKld0vpQu6AI6z8=;
        b=ASeGSEvPB6W1QIyuoAtnUad4rnuJqh8yOYubK7cLLVtzBvMOjd0T+VsVzChIopHiyd
         IqfrtZhbBt8fhvrnkl50Ai2Oumz8AWJcCoNOZiGB1Mmdf9Eb6tCKpER+ghk4DN1MfB+m
         TE1F3DKSVjKh+AK8PwvQg6eMA6PrlxuwqETqEkrdeNatGivvMJ0ircYWO1+4obMQODWz
         685La4hki1GkmeoTQ1U1+6G9x7Gfdp2miMmj/k+Ru0kRNchXN3AoAkSWw+hQImA/ObtI
         geukqjp74OtBIcH6DRbRn6dhaqxsS3x1u+BN/JowKPOOchs5+842yBWXU7j7xu+9Om8h
         5dCw==
X-Forwarded-Encrypted: i=1; AHgh+RqYVHMdKScrj76gzBW0Mg03znuT4SP/G6pKNRhnJZaBH3tVdzV5iToGyMAR5rqH83hCbso=@vger.kernel.org
X-Gm-Message-State: AFuF++nQBYuU165zHJqGn2KGx7AtkM9fS1p4ElWh+Jff81hHiUPCoNHE
	pj6mUEL5PdMQ+rAZNZreWvK3jltnoDB7ND968Ml8mExrOV7uPABaPAamtJ2l7Uyq8JuWn1x0qE0
	9fFdRafysnkS837imH9L/xKm+WG0hpksAH1jf1pNqVHM98QrQCMJeAKaQ
X-Gm-Gg: AR+sD12lS+25ZDES/MaYn2bd3ui2vbCvzkf/U7kelNp7H0O2MPK5Tq2xwj2z0Sc/KHg
	9+5hfMMlql/0AlR5Js/rl/f4P+jUGkc61VZM2VhayXLyINtvKYPrdUgwNhplkKNiNdvyUPd8IvV
	rMwybwGsqvQE3AoXnSzja9Hz3GELeZa2OY6rq18eoh201FUZzFZ2g8wRjryGTDhAJJsv4TcItyV
	dR+U2eNUT7eWKz7NCWgttG+27DhjO45/wDe5RmsxQ32vt1rZ3CcJZLiZqMScBbpUMTJzqDbqFMn
	9qsJLpFGr52WkQZpTXQqscbkvYXPhtwnxYJSK725l9aLimQqciDTnAsRXuuD+rlyUihm6k9AsrJ
	6y6C6HxDkQ/b1mp95wJcq/OqiOZwfkDY=
X-Received: by 2002:a05:6214:3284:b0:8ec:cdb2:5e11 with SMTP id
 6a1803df08f44-90c80944085mr245242406d6.2.1787545673632; Sun, 23 Aug 2026
 21:27:53 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 23 Aug 2026 21:27:52 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 23 Aug 2026 21:27:52 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aohUbUKcvUaoVFEc@google.com>
References: <20260818-gmem-no-return-page-v2-0-5298f42d49bb@google.com>
 <20260818-gmem-no-return-page-v2-3-5298f42d49bb@google.com>
 <20260818092717.3F4871F000E9@smtp.kernel.org> <CAEvNRgHEVxO+1Mkoc3-c2+qSrKWnD+BDe04NBvuwGU6BL0amzA@mail.gmail.com>
 <CAEvNRgHX-NebA7z3twusis35E_grJNTrbse7aUZ6+D=qpQn14A@mail.gmail.com> <aohUbUKcvUaoVFEc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 23 Aug 2026 21:27:52 -0700
X-Gm-Features: AcwNN1WhbH4c-NgfbWkg3bEeOg-8KA8lr3Xwk93Joy7eFGoTTGPATKUswa3gE6A
Message-ID: <CAEvNRgH5ZQPGYzg+YdtEktZ72DgK9PBbzcmC_QFN6M0_6wuo1w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] KVM: SEV: Drop page refcount early in VMSA reload
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, Oliver Upton <oupton@kernel.org>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Aug 21, 2026, Ackerley Tng wrote:
>> Ackerley Tng <ackerleytng@google.com> writes:
>> >> This is a pre-existing issue, but can this allow a malicious guest to
>> >> cause a host kernel panic?
>> >>
>> >> Looking at sev_gmem_make_shared() in arch/x86/kvm/svm/sev.c:
>> >>
>> >> arch/x86/kvm/svm/sev.c:sev_gmem_make_shared() {
>> >>     ...
>> >> 		rc = rmp_make_shared(pfn, use_2m_update ? PG_LEVEL_2M : PG_LEVEL_4K);
>> >> 		if (WARN_ONCE(rc, "SEV: Failed to update RMP entry for PFN 0x%llx error %d\n",
>> >> 			      pfn, rc))
>> >> 			goto next_pfn;
>> >>     ...
>> >> }
>> >>
>> >> If an untrusted SEV-SNP guest modifies a guest_memfd page state to VMSA
>> >> using RMPADJUST, and the page is subsequently freed, rmp_make_shared()
>> >> will architecturally fail on the VMSA page.
>> >
>> > I need some help with this one.
>> >
>> > For the initial VMSA page, IIUC snp_safe_alloc_page() gets a
>> > non-guest_memfd page. This won't ever go through sev_gmem_make_shared(),
>> > so we're good. snp_leak_pages() doesn't actually leak pages, it just
>> > tracks leaked pages, but __free_page() is skipped so the page is really
>> > leaked.
>> >
>> >> Because the error is bypassed without calling snp_leak_pages(), the
>> >> firmware-owned page is returned to the host page allocator.
>> >
>> > For guest-provided VMSA pages, those can be guest_memfd pages. The
>> > refcount taken is the one guest_memfd holds. Without considering
>> > conversions, just considering truncation, sev_gmem_make_shared() is
>> > called from kvm_gmem_free_folio(). Sashiko is saying that
>> > rmp_make_shared() will fail, and the folio is freed.
>> >
>> > Sounds like this would be a problem if the folio is used elsewhere...?
>>
>> I looked closer, "15.36.12 Running SNP-Active Virtual Machines" in APM
>> Vol2 says "After a successful VMRUN, the VMCB page, as well as any AVIC
>> Backing Page and VMSA Page are marked as in-use by hardware, and any
>> attempt to modify the RMP entries for these pages via instructions like
>> RMPUPDATE will result in a FAIL_INUSE response. The in-use marking is
>> automatically cleared by hardware after a #VMEXIT event".
>>
>> So it's not true that rmp_make_shared() will always fail on a VMSA page,
>> it's only true if the guest vCPU is running.
>
> Correct.
>
>> RMPADJUST sets up the VMSA page, and telling the host using
>> SVM_VMGEXIT_AP_CREATE is how the VMSA is set up to be usable. Then, the
>> other vCPU needs to be started and running, and then:
>>
>> If the host truncates the VMSA page or host closes the guest_memfd file
>> containing some other vCPU's VMSA page, sev_gmem_make_shared() on the
>> VMSA page should fail, but the page is released anyway and we have a
>> problem.
>>

74bdfb2f6d18 ("KVM: SEV: Forcefully invalidate SNP VMSA if its backing
gmem page is zapped") fixes this :)

I didn't follow that full discussion and now I get it. Here's an
explanation from another angle:

This VMSA invalidation is interesting in that there isn't really any
communication to SNP, because the host doesn't really have a direct way
undo the RMPADJUST.

What the host can do is to RMPUPDATE the entry to be shared, which is
what truncation already does. The key thing is that the RMPUPDATE has to
be done while the vCPU isn't running.

Other than invalidating whatever kvm is tracking in
svm->sev_es.snp_guest_vmsa_gpa and in svm->vmcb->control.vmsa_pa,
sev_gmem_invalidate_range() has another side effect, which is that if
there is an ongoing invalidation in another CPU, it keeps requesting
KVM_REQ_VMSA_PAGE_RELOAD, which stops the vCPU from entering the
guest. Keeping the vCPU out of the guest is the thing that allows the
RMPUPDATE (rmp_make_shared()) to work.

This loop keeps the vCPU out of the guest. It's kicked off by
kvm_arch_gmem_invalidate_range(), and loops until
kvm_gmem_invalidate_end() is called.

.free_folio, which does the RMPUPDATE, is called synchronously between
kvm_gmem_invalidate_start() and kvm_gmem_invalidate_end(), and so we can
be sure the RMPUPDATE will not happen while the vCPU is running.


A guest-provided VMSA is set up for a given vCPU (identified using
apic_id) at a lower VMPL. I was also wondering: what if a guest just
decides to _not_ report SVM_VMGEXIT_AP_CREATION? Is it possible to just
RMPADJUST and not tell the host, such that sev_gmem_invalidate_range()
doesn't know about the donated VMSA?

From working on the reproducer I don't think this is possible, since
without informing the host, there's no way for the guest to use the vCPU
with the RMPADJUST-ed VMSA. If there's no way to run that vCPU, then
guest_memfd is always free to RMPUPDATE to make that page shared. The
host can always RMPUPDATE a VMSA page as long as the VMSA page is not in
use.

>> An unsolicited shared->private conversion is fine since the VMSA page is
>> already private.
>>

I need to look at conversions again to take this into account, will
explain more over on that series.

Meanwhile, there's no issue here because rmp_make_shared() will succeed,
so the leak won't happen.

>> sev_gmem_make_shared() would fail on an unsolicited private->shared
>> conversion. The RMP entry would still indicate private, and guest_memfd
>> would track it as shared...? Bad.
>>
>> I've been trying to write a mini reproducer like a selftest but I've
>> still not gotten it to work yet. If someone knows there's no issue here
>> please let me know!
>
> I have a reproducer I created to prove and validate 74bdfb2f6d18 ("KVM: SEV:
> Forcefully invalidate SNP VMSA if its backing gmem page is zapped"), I'll make
> sure to run it when applying (the final version of) this series.

I got the reproducer working :). I'm guessing sharing the reproducer
publicly isn't allowed so I won't.
