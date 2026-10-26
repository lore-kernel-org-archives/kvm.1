Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793054554;
	b=29tLAdZ5glvt+5Q18BIybdwwk/abFRLZdetBeCFCI2LV/2jHezsogTUtnmQVUmVzwDzD
	 mTnD1YUQe17FSmXN8xbl3ssJCJnvGkH5rvSpvKaRLFgxEMhM2IAYSsHegx/7SJszhU0wt
	 CSy/8B2phLdXngd1ECMPyQD2B9ip0L4+hFRSGtAWozIajkw55BCw7gYEoiS2AVvD3WmY6
	 vnZerMMJCD+OF4zgrd4D6e570y1rPCGkXWxYHok39yLtZNa/58nGEW1mvAyktyoyPOxmr
	 tRiZOiPFJbaltMoaNSEYU3fuMmIutX1da0+dT7JXLkbEDFvbvfBjiKzxDdqPr4KSC1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1g41ScjhVwvRbzMcxKIfOWek1hrUNmo67dv5vjZ2E34=;
	b=dtG2LmVmJD3x0tOmGU0vOOKqWNR96hgMEuUODOOrW+vaImAPhnBcEsUJcshjY1S8n+ij
	 7MEXIYPqbY/Tn3Ov33GTpul6LuHV8AlFf11sjLGcs++n97tDrcIusmup+JOlx+gXv/6m/
	 XsEXLVHlsy2K3abxlDn/byGfHl5dI0GxA0wm5jLRr9je9xtYEkbY46vo7svnz9xHxFgV+
	 3GwTNOYmuMmU8dNhr+Nw6bmHZEFVut4GsWxJlmSJjLutoNyjskN4N8MiPM82oADDNi6VT
	 GIzWwb28WgQkadj98HCFhXpoeWcRF3OsUI31mgGAiNNHEmO2hKOfTj/R1lq9sJQIYMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ho8+h6Mf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955A7606A32C
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 22:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 955A7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ho8+h6Mf
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4395d31228so525983566b.1
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 15:42:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793054552; cv=none;
        d=google.com; s=arc-20260327;
        b=PDClMuJoYGK9k41lXV+b4Ae2mpYrCfrzU3tF+coQ6GAzOcPMlyIw3ZVtTRrAFb04HY
         rJ0Gw0Mfp8DWY/ybWy2bkynVbIrVDSfR1One4YkBRNQCR41ywiWm0Y/6Nio5dkNdC4ZZ
         SXnRsWVN1LWGallpZ6hBZkpgjw/aGmyiCtJ/Q0Asf8lQov8zCyhEJYaTAI3PIQ6BF19A
         MNzkKgprMztok2n1jd5fKF9Et4/bgHYEhjIwmgSrNLA0jfQMX311z6zEv4Bnln8g6QTq
         oZTinLgdo7pPC54CPyLIoX4kr/dXmfiBXkIp0crY79dMI03dFLBw09LqDGpfBlIenLwI
         /WlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1g41ScjhVwvRbzMcxKIfOWek1hrUNmo67dv5vjZ2E34=;
        fh=TevP+hAl2y6l96+KkPc5hGVUoIxK8h/C5QKCqailDk8=;
        b=nZ4u1qMPH4x/vcBUzQI9Byur7M+AOeTMkosepD8NhUXBCDFH5BROXk+igZu1Cdcwwv
         J4M/StTSxW3Xl61z4Q4Ai8V5ZulsZ9LQR4fI7h161CXcX8JSKMzrt0BMiW3ou7T99wOD
         6YduZZGvyu/TqPlkEAoIZTcxzRZMEF3q96kY2BSMOlVvocbThUnrkzgOAdlQBb1JhiFI
         JX6d5TwRk0to3uhdA5LkDUyiRyu5upZMc7/l/4WgEEaRtgzJswZ/9Bk8effGkI1tmt4T
         4+mIg5Yw4unwc4pxCA2jhGg5oc/MVehYvKQhq55BqGlL34S9aKLrDpPABUJtJUGX2efy
         LSmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793054552; x=1793659352; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1g41ScjhVwvRbzMcxKIfOWek1hrUNmo67dv5vjZ2E34=;
        b=Ho8+h6MfzfNYBnYXWcB1Csn7RkH5FDAzc185C3faxOFFVI5Ip8rPZvUVVS9a7mPz36
         24gi8R8N3yA+KvfwmaRReqCQoQsNezGiPP1Bp7GiihlQBrxNS9eCbaY93g0l7+W+vIC0
         voQ2Heu+uMnZMYR6TuMnUotBhMhKn8fZO7YhZJ/VGMtSyWbiopW5EZJQ5vT2/6dOt2QP
         h6y7P/JEcSU5qhjYmxEPNqjJ3oooD2zuidI/sWorRbLSpg0w4GfbG7VlXLnZBZNxscre
         60kjozBonZXdnmTiD0g6qsMUd7kqNlcLdjiG7bhzjYU1/2dfEHHIUzSVvBAgpzwQCCET
         IiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793054552; x=1793659352;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1g41ScjhVwvRbzMcxKIfOWek1hrUNmo67dv5vjZ2E34=;
        b=Nddt6otvvtw/p25X3g52nIIeLOrSuibOewXcThDHe6mOajGDtb+cnOz3qJVtHepBfy
         SFIqcQ0t8qVsAzBS5eDbubFqK1EuOXMPgjcJX+KMB+lfNR502YTVmINx0vRgUize3wba
         3mruUnAPH5S2YDvraA9bGp6D+nNIYN+A92tZ4KrPfP8JOxMw1Q/D8ch/MMRLtc9pqRyg
         nz2qSJbG/tqhus6RWgqWtpYeSb5yfxS6Gub2urLTRIhvVlmKqODQgG6xJuSKmTjNy5Pf
         a2yRzORqTGdDKT+JCHOJoQOu8+dqPqlLQwQsyol07LjZJlqdBYP4aQ7Wphkgek5/Gwpr
         tPnA==
X-Forwarded-Encrypted: i=1; AKwUvBygC2WdjbwuCdZVNLVmzZlhGKUMsKqT/zFYhlEqtMBen4GaZ9ronwpRFOeGI1CG6zfXIx8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpQo/MAOPNyadpjTRXcld0jLlHid9IFTgKXq4l09hTb2X6Ou9F
	G2VBrsx/GlLIw9mH6V/Zg42iV+98IAdd2ajzaSH5jWrh8xG/PuEkP1VGEnOcENAKeFROPjl+dZe
	V7Rya+aUfvRz6xcPwE9KmOgFEa2iAJHH+wbpYT9hq
X-Gm-Gg: AYBFou21gIDzb3ZUththaylqgjsI0Nj0N5ehMWD9b9ZAptzyDR1XRsZ690DXd/RI6+H
	bCRJ9zGXhheVS6Ga/btue7p8x0/znDAEmx/xsieGbRx0rpd5grUSObU+jl9NRFKnazv/YgMX1Gg
	CC6NdUJmG0y4V+wzT4OcQe9lJgje7BXPSBMpcXsvbOYdp7HkDQaACoFuRWcsFusBcxDo0u7RO8Q
	erYyUPA57s91OoYubL5XRx4CQH+nZZlk2oM+E21ww1cUfL1KZ4xjiXm8w1rcN9JldoPxLFT1gJo
	lhOZhqZVrOjqBwndWYIoO/YQ3GlEz0nkHVVGu3aja7m7bY7ki79oEN35ZgCleRzNtBBl/gjzhPZ
	byhwPIHF+Gervq4nnTSBwDIsTXto24VvksjyTf++vDaOVjS1Vj0WL8K65jpjt8+1/dMt6SbqeUE
	DH3l8oOBExeDUCpwPMetvQhm9qS1xij40mB1BKO1/4d7Q+l2yUnd+rZ1sNLJCs8vtLFr7NmlxKg
	b2vDx6S
X-Received: by 2002:a17:906:4fcb:b0:c46:8733:642b with SMTP id
 a640c23a62f3a-c46bdeba20dmr991156866b.43.1793054551213; Mon, 26 Oct 2026
 15:42:31 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-9-jthoughton@google.com> <da7bb91d95914febc9b2b981c0b8292022d6f6437ecb68ed2b717f0f4a3a04c2@mail.kernel.org>
In-Reply-To: <da7bb91d95914febc9b2b981c0b8292022d6f6437ecb68ed2b717f0f4a3a04c2@mail.kernel.org>
From: James Houghton <jthoughton@google.com>
Date: Mon, 26 Oct 2026 15:41:52 -0700
X-Gm-Features: AclHuK9NQf_DmtP280VFWB18VLK39ZMzdxZm9Qsh_-4Snm7U1eOCkiznChHcSHY
Message-ID: <CADrL8HXA3KVX9agtcExpPuaBLC-zAEWx6QgsRnQ6+cb4AZZrFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 08/10] uaccess: Refuse and warn on __copy_from_user_inatomic()
 without an mm
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, tglx@kernel.org, 
	peterz@infradead.org, kees@kernel.org, arnd@arndb.de, david@kernel.org, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, seanjc@google.com, pbonzini@redhat.com, 
	jmattson@google.com, axboe@kernel.dk, asml.silence@gmail.com, 
	James.Bottomley@hansenpartnership.com, mkp@kernel.org, dsterba@suse.com, 
	mason@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, jpoimboe@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andrii@kernel.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 3:30=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > uaccess: Refuse and warn on __copy_from_user_inatomic() without an mm
>
> TL;DR: Commit message only: it names kvm_read_guest_atomic(), which no lo=
nger
> exists in this tree; the review suggests kvm_vcpu_read_guest_atomic() ins=
tead.
>
> >     uaccess: Refuse and warn on __copy_from_user_inatomic() without an =
mm
> >
> >     __copy_from_user_inatomic() never called should_fail_usercopy(), so=
 the
> >     NULL current->mm check added to uaccess_should_fail() does not cove=
r it.
> >     It is used e.g. by KVM's kvm_read_guest_atomic(), by several
> >     architectures' perf callchain and stack trace code, and by the gene=
ric
> >     copy_from_user_inatomic_nontemporal().
> >
> >     Split the NULL mm check out of uaccess_should_fail() into
> >     uaccess_without_mm(), and use it in __copy_from_user_inatomic() to =
warn
> >     and refuse the copy.
> >
> >     Don't use uaccess_should_fail() there, as that would also start inj=
ecting
> >     failures into __copy_from_user_inatomic(), which some callers don't
> >     expect to fail in practice, e.g. __wp_page_copy_user() warns if the=
 copy
> >     fails twice.
> >
> >     copy_from_user_nofault() already fails quietly when current->mm is =
NULL,
> >     and the generic user stack unwinding entry points (perf_callchain()=
,
> >     get_perf_callchain() and stack_trace_save_user()) only unwind the u=
ser
> >     stack of a user task with an mm, so neither is affected.
> >
> >     Signed-off-by: James Houghton <jthoughton@google.com>
>
> The changelog names kvm_read_guest_atomic() as a user of
> __copy_from_user_inatomic(), but that function no longer exists in this t=
ree.
> It was removed by commit ef82eddc0e31 ("KVM: Remove kvm_read_guest_atomic=
()").
>
> The KVM user is now kvm_vcpu_read_guest_atomic() in virt/kvm/kvm_main.c,
> which calls the static __kvm_read_guest_atomic():
>
>     static int __kvm_read_guest_atomic(struct kvm_memory_slot *slot, gfn_=
t gfn,
>                                        void *data, int offset, unsigned l=
ong len)
>     {
>         ...
>         pagefault_disable();
>         r =3D __copy_from_user_inatomic(data, (void __user *)addr + offse=
t, len);
>         pagefault_enable();
>
> A grep for kvm_read_guest_atomic only finds __kvm_read_guest_atomic() and
> kvm_vcpu_read_guest_atomic().
>
> Could the changelog say kvm_vcpu_read_guest_atomic() instead?

Yes, that is correct. I've applied this fix in v2.
