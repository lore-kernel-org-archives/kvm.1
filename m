Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFBA2E8DFC
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512170; cv=none; b=uGWbyV4ynUHdx5zHSAKrPuzBZAzhMmax8892DE/vg2Av4Lf3k3eW4OvmBL35nX84ZkiZWxbedf2crFJH5W85WZenZUdw3TuXM++MlVLXqaIyJRR480Uze78KmwZaNZZlJYw3ShJOyS+bhPjqa/a1+9nTTFJeHKtxpTlK0wDLePg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512170; c=relaxed/simple;
	bh=bg9GTPM4qZhMdSfg11A/iGfcWjT8zOB9yw1Am0GGvQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/XBR8s/Y3CU1CO3+paS/Bajs86clcDUfsICzsmM69eHG+Bq0YIEyg4EPL+FqyGRUmC1TZbg+DqHaefpv3WXhrJqMm96u0ABg+o3Js/RnYTkQNVn3lbMnZzFr1/tv3HaqNm7FAZzKOV7q/IGmEE+lz6uBGUFAkE7A8Bp2XupW9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQXayTiz; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQXayTiz"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67bce1840f1so6967687a12.3
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 08:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778512167; x=1779116967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qOSaj4W1IEQKE4qx0BHHr2CD6pWbcRcUhaSAZDeDA+g=;
        b=XQXayTiz2JobX/nWyKgZPEmxSzluuS9aefX76sDxT3ibyakvBtZiCSqHXrVD1hKevT
         MFC7I3UxVgJKoMRIYmJdG4vISgwjJ2uNVP+j5FWx8GqDYv2sFVgR7yQaEuwpS1NUILnO
         3GuAmQu/5BeC9IYnJmdxOum39lk4syzSCR2tp8gsG3xSV05WDaXgQEaPKIR5krpzGPSE
         UAsu+6DN9c/nBWlCGhpFg2FFjvqnqxFTMUczf77pgq5TUppNZw4JcKaxxCDGXcYi9If0
         +UEKwStjNB9N5ETtpzY4rm7K4kfL59n1sNLoNtFp0hwbJzOIK+ycm9sqKARccaF0wFDR
         XSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778512167; x=1779116967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOSaj4W1IEQKE4qx0BHHr2CD6pWbcRcUhaSAZDeDA+g=;
        b=WgCn4O4AdDexRG8jKa5j786gocdVHUt18fb4YSBnubaQ/dOCD7AOd5zWPt2Ng0Usdt
         tNP0KQvJSdy9/UjZorcs4Tsr22h5Ix/lnWLOiRrYzzlgXtQl+ZUo1Sfg3tTLCT44qpRd
         fxzDxyRHbdKQrFi0P5TsoGyiLAtRB7TqxReoC52tQc/zQvOQRuCHzhO2F9/o8GhiFF5P
         G6spdhU9pQS1VpVDDvLea3DCXqlp+btQ30VwLJr1/m7F2KGOikn+1bSrZH1RALD43bZV
         +a9pcB7QopYpO1cVboECS0oVWoXH4DhXXOpJIjkK9Qr6G94gVStfAmHB1CrqQWpwdp+H
         Ck9g==
X-Forwarded-Encrypted: i=1; AFNElJ+lHF8Lkj4nXLySZlgcv3MpD9S1fzzWYZ38edWKqkj66DmwGfG/cR91wrNWKYsaTqfBdFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy6HU/+XO+axPjDTV4Zf1X32SG3wuGKkS7hkFrPgBkShqpm2u1
	Pgb5+ycYokNBTZFDSW7zwqGNeSrAi6bROD/U1ejrjkUWCXj7Ut0AgQLokExG7L5bUfw=
X-Gm-Gg: Acq92OGYL365TzVu4JHNhxXCzvisVD6mIS1WpheoMnJPmrpixYwZmAEq2MgJ5ziyZ5B
	SK+dac1tczAM1l/xkHdN/3R26cYWQg3TpZbgQdHcOCOCHhndjbc2hUaj8SCRgJjr8qF9zn8pB3G
	VqMYBdw+W7jZo/fnwRGLqeLHGhEH9xL9qOGPTM6mrhfe5ks9YMbtMhVIdyiY//hkib3Ya0TGV84
	Pi6NxuiF6txZewryqCxF4WAsroONWW8H0C3iDaKTWMJejCRflMDnqpO2Kkt3B56aFEMbeqbIuqq
	RcRpAPSXp0TJyzjRaJdWU5+U/NizNWczZ7sg0RIrFnf+epHWDspTnnC0uco+tugMxvCnvJJKmIc
	/esAUWYNyfxVrVKXYxeWosGs8fBDXg89Mk+P6Fdh32ujycRdxrs+q4S0ZdFNH6UPyNOhynfqB/B
	aOO83YFSFTvVvk7QJf1dsHWZebNNb+EQ4z7BiZfRGkxmX1giUC7SMpQTsukIvl8QvcMpi2qpZdR
	XxORmMNzwtH
X-Received: by 2002:a05:6402:2749:b0:66d:d2f9:520c with SMTP id 4fb4d7f45d1cf-67d645baa54mr11817516a12.19.1778512166447;
        Mon, 11 May 2026 08:09:26 -0700 (PDT)
Received: from localhost (226.55.classcom.pl. [195.150.55.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0e0d4bdsm3938024a12.23.2026.05.11.08.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:09:25 -0700 (PDT)
Date: Mon, 11 May 2026 17:09:25 +0200
From: Piotr Zarycki <piotr.zarycki@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: sync_regs_test: use
 KVM_SYNC_X86_VALID_FIELDS
Message-ID: <agHwV8Btww3ku3Xf@arch-piotr>
References: <20260511143426.1242013-1-piotr.zarycki@gmail.com>
 <agHuMh96_kDr3ENG@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agHuMh96_kDr3ENG@google.com>

On Mon, May 11, 2026 at 07:56:50AM -0700, Sean Christopherson wrote:
> On Mon, May 11, 2026, Piotr Zarycki wrote:
> > Use KVM_SYNC_X86_VALID_FIELDS instead of open-coding the same three
> > flags, ensuring the test stays in sync with any future additions.
> > 
> > Signed-off-by: Piotr Zarycki <piotr.zarycki@gmail.com>
> > ---
> >  tools/testing/selftests/kvm/x86/sync_regs_test.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/x86/sync_regs_test.c b/tools/testing/selftests/kvm/x86/sync_regs_test.c
> > index e0c52321f87c..8f9239f9d357 100644
> > --- a/tools/testing/selftests/kvm/x86/sync_regs_test.c
> > +++ b/tools/testing/selftests/kvm/x86/sync_regs_test.c
> > @@ -79,7 +79,7 @@ static void compare_vcpu_events(struct kvm_vcpu_events *left,
> >  {
> >  }
> >  
> > -#define TEST_SYNC_FIELDS   (KVM_SYNC_X86_REGS|KVM_SYNC_X86_SREGS|KVM_SYNC_X86_EVENTS)
> > +#define TEST_SYNC_FIELDS   KVM_SYNC_X86_VALID_FIELDS
> 
> Explicitly defining the set of fields to test is very deliberate.  (a) we want
> to detect ABI breakage, e.g. if KVM removes a valid field.  (b) if a field is
> added in the future, the test likely needs to be updated, i.e. would break if
> KVM extends KVM_SYNC_X86_VALID_FIELDS.  (c) KVM_SYNC_X86_VALID_FIELDS probably
> shouldn't be defined in a uapi header; for all intents and purposes it's a KVM-
> internal details.
> 
> >  #define INVALID_SYNC_FIELD 0x80000000
> >  
> >  /*
> > @@ -255,7 +255,6 @@ KVM_ONE_VCPU_TEST(sync_regs_test, req_and_verify_all_valid, guest_code)
> >  	struct kvm_regs regs;
> >  
> >  	/* Request and verify all valid register sets. */
> > -	/* TODO: BUILD TIME CHECK: TEST_ASSERT(KVM_SYNC_X86_NUM_FIELDS != 3); */
> >  	run->kvm_valid_regs = TEST_SYNC_FIELDS;
> >  	vcpu_run(vcpu);
> >  	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> > -- 
> > 2.54.0
> > 

Thanks for the explanation. What's the preferred way to implement the build-time check mentioned in the TODO? 
