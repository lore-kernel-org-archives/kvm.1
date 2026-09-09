Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C4755C1D2
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968527; cv=pass; b=nATfpT+YiZ6aMF8alMW0gUXijEtlTXVM1g7QWCLjE1JOPIPs+X2A/PQxV89IIAU3gUvBpCjWj0Hw7LV3KbSQ/UqkJxsuNcFeeQvnVeTgvjcwAfy/OZhsr+rohdpU6bRtI1mrVi6r3B2NGpvQfIiUToyIvhbb/SY73M+0ltI1YwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968527; c=relaxed/simple;
	bh=LlddFKck7Cbtl7cf66qSmn1rFxhlvvhQVK4P3MceWSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvnzLC+uW3zWcFrnTOewupY0fsFJLEkb0sKUU+L/qqAg+aA8FF6YhVGCThNL32lAwzsrAQloAyB0cfiUDHB6W1D3AAnGORvH7iSnBy2821y6kJGA5Wc+p4L8B0huZeDk8UfMzNgsz5io594zYSNaXwI1Xvdr3z/ZNyS/chamrYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gFp+D/Q4; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gFp+D/Q4"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b23so234451466b.0
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 08:42:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788968524; cv=none;
        d=google.com; s=arc-20260327;
        b=Uult9L+LmgHffArLDMhZIdLpyR7V/J8fFJ1DgiPaqeuUk3CtqPjfmk/ICYOLARjQQn
         r7lTbPo3LYxUAFODuKIShgHXvg3iGzvk52pTlNkFPKOI6pC8ZxPGWZUOVCDUwNuBnN/+
         m04toh4mRqnvt7Jy8IMMA04wazqLYngvTMlepPWFN/MFfIzv7PUPLye3H1H2FqGxZNTf
         OQDbEo1Aqzxk5Ca+v72j/J6ri8KTeh9AHU5KJEEkhPbl3UXP2SdPMnIIvORXvCHuDNto
         +huo7hKXPaP8BMKDg2ieOjO+D2goSD9eBWoR7nYFlPOLXq0oDxvv40xpTTYiN1GR3mhb
         bYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N3dn5TYGV5agCqPjCqQ+csmVjiwwOdvOPtqg6BBzXUE=;
        fh=xE9SHO9kY2g2dxPx2flvWqwto0k9pG5z/CO+/+6r7N4=;
        b=Xhu5OvAw0fGzOuEib1D2xY3K4u7C6xmkPxaZ8HH1LzawTzvF01te18F2Eerx+IFAGb
         4nlruXJdgkwdrLFV9E8Z9RNeY9nM54dfuJZUeGwnQy4PU4saEDTnv8M2CMPQg2XiBt7Q
         /1PS76RcJ/Tqvmr7C18nMnA8q4lxElnAUyEvlEZG60zrzcXTX4XbMH6UopiDdDDq6GR3
         v2xdEGa253J2eHkSNNBKovokARdvRV1sMU7bkSP/F2BfOLtmnTsYC5sZs6QZbJTCRVyL
         sqdC7Dwx2AX4cfqFCA4MMAvvxcogpBUGyjStELBcuJqK6it60GrWYQKeg4IdPWVOz0iO
         R/NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788968524; x=1789573324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N3dn5TYGV5agCqPjCqQ+csmVjiwwOdvOPtqg6BBzXUE=;
        b=gFp+D/Q4gaxjW4e/OzUW0g2ckUttmqsGaa6iEXeGkvxFAeReBu/hVepaaNsUtFGubB
         3WlY8ae+rOlXhtwXpYrPdgMa6iy7j46VI7fo8iGuLQS6m5VHs9Z8jI2ZpJ5PXSdfVNC0
         noWTYEDlL5ffY8A8VX9JOREWfDERgHq4mUK9PheDcsdg5YUQdzuO24AY1+OhF9f1U5+h
         jt39GJQwPSRjJxoE5hkKtjCivZFyhFr34cHMZWBGgfL++tgiL/H3v+NM1tF3Ea2y2E7x
         JKuNyfiYJM6ecCTQ0p0Ha707/IebONSrj8gj2oilMWiUOlByBfZtb2rIl+yssIfh0j+s
         Dvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788968524; x=1789573324;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N3dn5TYGV5agCqPjCqQ+csmVjiwwOdvOPtqg6BBzXUE=;
        b=djUDcD40xytS3yJQADTeUaP4N5n6IwV0yyNq7aYuMSsjPapcopg/I+HhO/dB8YB9cp
         or08amRyCKge9eZc18R/cZc+NMb6bN54O2qdfLEwkeciybIBbvnoXB1vh750ytyqcnWc
         LmkD7YWt1ILSANPGaFW13qcDmT4caDZOFfs1NZVloBdWdB0lGiYwTlLQSmw8dQapFqf3
         mS8B+My9c11nFYYiyZX+ptgbDhlWtUXX6L52JtrdnuLw6jP14SxuwfMSmwYHh1rZBH0o
         /+ljxhEmcYCDWScmGJXnt2BMo0ixmnW/0xr/l0z3hqAKTMezIn53r4p9n6QARNdPJzUt
         SJ7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxlFDd2A3U6VnFVFsz/6HpEqfUaCzFcw3P1m7GsGBnup/kBOg16n0BHx/EKt6sj/G73K5s=@vger.kernel.org
X-Gm-Message-State: AFuF++lwJeAXfX+Gnxztq111zL/qC/o/s/8mxDDGMSfbjxgfIhn/a+67
	7MtIUYIDdXkTYp1HViRfeX33dpL8gS7OAsEQVxFSMRipea36tO16+CCSCJaqYtgUICJg+1s2dhK
	0e2rnGSriL+uTChhnd1RqHi5nj2KdnVL87E2xFKuHrkkik5SH8w7asqoa
X-Gm-Gg: AYBFou1E0PLrIzR+BRulNJz26xkdAaptB8iJMWxYkwXIkeW5GAZq+6FLFFLwqvNL78o
	GBTkcnx9RpSm3h1JgqxHdShJrcszjHRGOTRUdrHLAN39QDco2j5YtUihQg775h1pji0m3j05b8t
	COeQC5bsbCmyOMr2mz3o7kPmhSCwNngljcvyRPTuozbKVCh0TXeVEZAV3ZXhVPItfHFesrb/KGq
	wk2vue2bedvWIHWDsSf5Rfah9gkGAexP2ZB9/KCoRFxxYJ4jVdL5i7+ewU+wiY7ErsA4RmHl1xI
	weTBDKjgsrNH6JG+jX/0nAEZIHe0ApiyaaS8VJS8JU0oQ3MOHHdeLZCYbfhK0Vy4JOKSu2ozJ5Y
	K4a4VCFqtwd6ZAkxJAqA33D3w9otar87m3qsS+Wg6xX1F6hH2Atu+hE2gwr08llz3Xy0=
X-Received: by 2002:a17:907:c817:b0:c26:3190:2965 with SMTP id
 a640c23a62f3a-c292b1369bdmr624367366b.12.1788968523659; Wed, 09 Sep 2026
 08:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908132838.2116068-1-jmattson@google.com> <CADrL8HW3Q=8eBf-=h6BAPdUN_X1Z_-KG=i5a5rA2kF+V4JURww@mail.gmail.com>
 <CALMp9eRJXozpUpdOhqDCWn7VbqHb9G9hn4aZnxS_fef4ad1yTg@mail.gmail.com>
In-Reply-To: <CALMp9eRJXozpUpdOhqDCWn7VbqHb9G9hn4aZnxS_fef4ad1yTg@mail.gmail.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 9 Sep 2026 08:41:27 -0700
X-Gm-Features: AcwNN1Ukhgq6q__G7rqPGKWnJ807asXYRqEwL6FyIEahxFvLlFuJPzatqI0LcmU
Message-ID: <CADrL8HW89mwdaXKv700G1LS2ymWY7CoGV9VBF8QZWkPPC3eUaw@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Don't flush shadow VMCS12 to guest memory
 during vCPU teardown
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 12:13=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Tue, Sep 8, 2026 at 10:35=E2=80=AFAM James Houghton <jthoughton@google=
.com> wrote:
> > Hi Jim,
> >
> > This patch looks good for a stable backport, but I feel this kind of
> > bug could easily happen again with the current API.
> >
> > One simple thing that would have prevented this would be to:
> > 1. Change kvm_write_guest_cached() (and related) to take the vcpu
> > instead of the kvm, and
> > 2. Check that vcpu->mm =3D=3D current->mm before doing the uaccess.
> >
> > This wouldn't be as suitable for a backport, but I think it's better
> > for preventing similar classes of bugs. I'm sure you (and
> > Paolo/Sean/others) will have better ideas. What do you think?
>
> There seems to be some awareness of this issue within KVM, so that may
> not be necessary. Also, as Sashiko points out, we have issues with
> reads as well as writes. I don't know how many choke points we'd have
> to test.
>
> AFAICT (with AI assistance), all of the current problems are rooted in
> the following call to nested_vmx_vmexit():
>
> void vmx_leave_nested(struct kvm_vcpu *vcpu)
> {
>         if (is_guest_mode(vcpu)) {
>                 vcpu->arch.nested_run_pending =3D 0;
>                 nested_vmx_vmexit(vcpu, -1, 0, 0);
>         }
>         free_nested(vcpu);
> }
>
> On the SVM side, there is no comparable faux VM-exit. Instead of
> calling nested_svm_vmexit(), the teardown of SVM nested state is an
> open-coded sequence. Maybe something like that would work better for
> VMX?

Maybe, but I don't think I'd feel any better about it (because the
change is still KVM/x86-specific).

Thinking harder about this, I think it is always invalid to call
`copy_to_user()` if `current->mm` is NULL. The riscv implementation[1]
seems to require `current->mm` to be non-NULL. So I'd be much happier
with a check in `__access_ok()` that `current->mm !=3D NULL`, but I'm
not 100% sure that is okay.

I'm also trying to think a little bit harder about the exact mechanism
that causes the memory corruption. I think for `active_mm` (and
therefore the loaded page tables/CR3) to be different than the mm we
destroyed in `exit_mm()`, there must have been a context switch to the
victim user process and then back to the dying process after
`exit_mm()`. Right?

[1] See arch/riscv/include/asm/uaccess.h
