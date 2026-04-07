Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8B4376BF4
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 03:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775534344; cv=pass; b=KxTQpECEeSAR2f17cCWmuYjeNJeHcGyUehABBjLoijjlos6gpnOqC1jnkp5WZXKRDoVXEX1YpZ42jPc1M332Et8ldvCFIS91zW3lN0wWxKT4I37NAtatUocX4HWCCUFwjyT48JI9D3W7Tv3sbgXR2eC4MVOI1aiTBzR2rNHkGvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775534344; c=relaxed/simple;
	bh=mfzKgLqLZzYMsvQGYLY63k3H3j/n9cAOhMKsXc5Hl9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=As1yJrcNIh9b6Q7Z/x5rqcxHmESLQ5liufU8fo6WRajQWIv8OsniEwooIE3jaiKqph5W0mM0nm16quMY8qsGsGd9yG3xTGwNp/KtwztBIK4En3soD0UcmHxe3wl/zBy301jKDjWGvZaqAJWbbus/2D9VFCsDmg5QuqdOiOdDhkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oQk6jNYX; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oQk6jNYX"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so32368a12.0
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 20:59:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775534341; cv=none;
        d=google.com; s=arc-20240605;
        b=JgQdrASl1+ST+nHBScYkDlJhKDh1MJ4vOlAZaXOlsSMJe2FoZUACse7hw28QKUO76+
         S+Yji3qpNed6dZfLERaRz0t2tupZIpHy7iqkyb/eSb4vPf7UEg9SZYiJyLfIXgr9BtSe
         IAKmpIomihJ/JGc1ZSrAmOJwmYmSe5D7fGhOI5DPUylIWI6JHQeYsYktzu3opyf/mJ+/
         zqtX1aQkOybpNYcUCFqJoWPrtBXAg9qzJuZoqVhDXMZKur8VNQAwOz+sP0BxTudRN14C
         s8CcEh2MYFpMDFsx4SETpMX4r02i4jfKjTR44EybLA2HNugW+bn0WKp++9uxwaEmaInT
         5aeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Gp8YbEZRFqhe15YerLSFU9IKBLIqcpI1UPog9hHvAQ=;
        fh=OpD8TG7St9dK09yoZoIt8iS/QKydAxAuS5ssC89KcjA=;
        b=ZtKjYY2yJkiztR5jlXTuCAnNlSQNpyC9ZUEN+K3+pWsvW0KTetdBztgKbPOmSGR1ky
         ObrbOMU1A6WWh9HgTxbfexkHf/weY2eXKnvHFWiSYuJcTOLyXui5G2Fuo72iQ0R44RcN
         J1WA1crKU/xvKzSVruilUd45xlMU7R0Dydfok1iC/4f+7lnSkRZb+1GWSPrmUlhGQhiI
         bVLSMFUvf1fEH+lptUWO0fdabPO2l9h4PBq9GVFPn3WgjFJpN7+YF7qUWvd3tLjfq16E
         UL28i5rCdDihBzz9I3ai26ikbth9TW0X9/MZv0ldg+DMI0ofusfnauWcsNhiUveJMshH
         Jq/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775534341; x=1776139141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Gp8YbEZRFqhe15YerLSFU9IKBLIqcpI1UPog9hHvAQ=;
        b=oQk6jNYXCO/9sgZMwolqIwFskFhI0re5l4iu3mfkBjsOWwyb3F9fB3EcFsBEaJeMt+
         KTEt2eYasLLbpMRT9QbBw09p3YDMolAngiBxjRB1KGto30kefxBY7kBnRKavaG4M8q5F
         hymvWa4Yj8ABYF2k4QQ9bm6tjG3tE91BMNxoN7hj5cfzyTGNHa2th4JPOqRPdEQg/Mlx
         QwI0RvvrZi5b9smemZbgVB4Jd5q/8N43XoeNjkj6iYC4KbbSa4Dl77f48/AyOUduj7fF
         MZZOb8AGbZS5gLinDbusd6546LHN9WqSh1SLt2a/WVt1RRg3HzBzsBN9e12voUXIdGCB
         hqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775534341; x=1776139141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Gp8YbEZRFqhe15YerLSFU9IKBLIqcpI1UPog9hHvAQ=;
        b=R4BJ4c2sH/8ijC+b/Maekk0sGWAh0nSwAdoBM/SwZk/NyluULYA9oCeznc6o/mCRGH
         VICGzF5q0FNomkrl9Cf3BRhSI8TbCmF8ZW+jomsfJ6uCSzDA0CKzinzLS2rdGKB5XIHd
         telVc2Ivyd02IaxQUk2xSI3jECVCkguEu8h75DZeWhLK7KTg/TC/5Bgyb5a8CXBLC3Af
         Utj3EeXc0I6ImCEXtSUphgQY8hG9IZxL/j+8HRqec8jvf0Hwuz68FH4ovAO/c8YvKy93
         ZjWWVyA/B6oFHC/c7OvwjjNJWbrX7KZ6L8P2f/7CzlpMQME9wVlmbysdjPGGN+r/nUk2
         yJkg==
X-Forwarded-Encrypted: i=1; AJvYcCWdQf0kehW1KI6wif22HPRqFDbhsBw0wicqaPf1pAR6wvPFEv3vOlpqGVnKFDSdjXhDm6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIk0QYS+nEsCerRhjONNouOIYHuO4pSDwPpis9gLcAsjGPZXKU
	864x+nv3NhppxVYRvk3ymBM6mIezlXGE7j2Tc6fjYOKppZJQUSvimnOj2YhRQxWgWhCEGnlJExN
	/CfHZYRTvGY162s2Ahpq3+CpEcVtBHtLcC2l6+Zi4
X-Gm-Gg: AeBDieuGZ5tX1p15ReWqVs1ljdT294Q9idSCxk0Be9hw6K+4om12/nZhKpLa7bqEsIv
	c6HAS9twPniCbAZZmCrBWEANg3AWG2y8fOSZbi86zekKaS/CmlHMiFXmK5vcIHZ1LaACIxenIx8
	L6L+1FHuD591JaRiY0hyUaNHFujUFY/F4tvpZ8UiFCzBQbJU9Zk0CadvpNtII5eYaKkq3I0jfdE
	4izgs8rDM+Mp4ZgpcZRclzWpnp2ncg0fqPjt9pAwN91IIkdoQuNAENR7SCwOGSvZpWLsneCba58
	H3Q9XYY=
X-Received: by 2002:a05:6402:a215:20b0:66b:b6d8:c0f7 with SMTP id
 4fb4d7f45d1cf-66e40ae6f4emr91714a12.0.1775534340995; Mon, 06 Apr 2026
 20:59:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327234023.2659476-1-jmattson@google.com> <20260327234023.2659476-10-jmattson@google.com>
 <adRK0dyF9QAsZyVz@google.com>
In-Reply-To: <adRK0dyF9QAsZyVz@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 6 Apr 2026 20:58:47 -0700
X-Gm-Features: AQROBzAR4L9hartxNauJf5yfV8dXpfTn1DNBr0PmrsEV2bOZT00NXIY1ANXG8VU
Message-ID: <CALMp9eT_+dAS-4Qz9cRGx5n+f7M=svOGpcSk_Kv7QyQw9nVWTA@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] KVM: selftests: nSVM: Add svm_nested_pat test
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 5:07=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Fri, Mar 27, 2026, Jim Mattson wrote:
> > When KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT is disabled, verify that KVM
> > correctly virtualizes the host PAT MSR and the guest PAT register for
> > nested SVM guests.
> >
> > With nested NPT disabled:
> >  * L1 and L2 share the same PAT
> >  * The vmcb12.g_pat is ignored
> >
> > With nested NPT enabled:
> >  * An invalid g_pat in vmcb12 causes VMEXIT_INVALID
> >  * RDMSR(IA32_PAT) from L2 returns the value of the guest PAT register
> >  * WRMSR(IA32_PAT) from L2 is reflected in vmcb12's g_pat on VMEXIT
> >  * RDMSR(IA32_PAT) from L1 returns the value of the host PAT MSR
> >  * Save/restore with the vCPU in guest mode preserves both hPAT and gPA=
T
> >
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > ---
> >  tools/arch/x86/include/uapi/asm/kvm.h         |   2 +
>
> Don't update uAPI headers in tools/, they're not used by KVM selftests (p=
erf
> folks will sync them as needed).
>
> > +#define PAT_DEFAULT          0x0007040600070406ULL
> > +#define L1_PAT_VALUE         0x0007040600070404ULL  /* Change PA0 to W=
T */
> > +#define L2_VMCB12_PAT                0x0606060606060606ULL  /* All WB =
*/
> > +#define L2_PAT_MODIFIED              0x0606060606060604ULL  /* Change =
PA0 to WT */
> > +#define INVALID_PAT_VALUE    0x0808080808080808ULL  /* 8 is reserved *=
/
> > +
> > +/*
> > + * Shared state between L1 and L2 for verification.
> > + */
> > +struct pat_test_data {
> > +     uint64_t l2_pat_read;
> > +     uint64_t l2_pat_after_write;
> > +     uint64_t l1_pat_after_vmexit;
> > +     uint64_t vmcb12_gpat_after_exit;
> > +     bool l2_done;
> > +};
> > +
> > +static struct pat_test_data *pat_data;
>
> This is ridiculous.  Whatever AI you're using is reinventing sync_global_=
to_guest()
> in a very obfuscated way.  Drop the indirection along with the params and=
 the
> full page allocation, and just sync the damn struct.
>
> Actually, this is even dumber than that.  The "data" is only ever accesse=
d from
> within the guest; it's used to pass info between L1 and L2.  Drop the str=
uct
> entirely and just write global variables.
>
> In general, please clean this test up before submitting v8.  All of the L=
2 code
> is basically copy+paste of itself.  This is the second vibe coded selftes=
t (AFAIK)
> you've posted, and it has many of the same flaws as the first one[*].   W=
hile I'm
> not opposed to using fancy tools, and the bar is generally lower for self=
tests,
> the code still needs to be readable and maintainable.  This ain't.
>
> [*] https://lore.kernel.org/all/aXJal3srw2-3J5Dm@google.com

I contend that the kvm selftests infrastructure already fails to meet
that bar, but I will toss this in the bit bucket and write a selftest
by hand for the next version.
