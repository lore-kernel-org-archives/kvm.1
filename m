Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDEB4E73A8
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792103071; cv=pass; b=tfEhL2CWEAHvK99PMpXL7MRHqZRhrXI4BpVz1myRtwp3KVD/4536YMW+m8rmWsen0+x6T+ebCHT1BwmS3Oj1ykhjg/TEqQeaextF4Ba/1xSRwMFcRKB1w6Do0vFXCeEh9ndaSOY0ubRjOk5OXs2SeV3PqxlO1Su9UuhiQy2w3Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792103071; c=relaxed/simple;
	bh=JsHIw7j65xDVOcoDPikKv7uu3ebdMMVU+ZxDmQjoXQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5/U597DCcxDfai2ZZFtzPdWcW04CC3MyeI/VEAKAHhsFwp97iAcCt67j0H24oKZoJQRbupUFtCN0vb0IbeaZVP6J+qr6XkLTqlR/57sOqAVpMMZOJuonfHC1G4D08Oq4DvyoYbEvz3d0oxuOPSyiG1Xv5tchX5BQ33ii0PJS9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eatGLZ1A; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eatGLZ1A"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-533202fe429so119281cf.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792103066; cv=none;
        d=google.com; s=arc-20260327;
        b=Jq7nTWqw8pT1cd1vNb5CCVotVZKGgUW9v4UQE1jWj6Rj/9hvPjmOyiusoLHLrGzS4X
         0rU2jBvpP5Rh/ZuEA+rXq+wZzy9VwT0zGKCkBciC9DUniRGQa6KziEQPFaX3ast9INX1
         DinURNQbS5RJbLnvXNB80fDW/TmCeNmWxNC1zgDsoM9mW0jC90if2mAi3HpqUiaBFppQ
         9a5YTq/EygOGdItSqxhrbRdshOtY73q2EszRQQ573VnBk6ZyN4M2bQf/OtZae070tk41
         N6wlG2mp90VngegUPshq+0c+kFIJ0Cxhfce6Khk0oPDIuSWzGzJSiUVZ6yoXeIX/9oM1
         DbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JsHIw7j65xDVOcoDPikKv7uu3ebdMMVU+ZxDmQjoXQw=;
        fh=/EGxHuCyu16ciyi2q5hTCsxiGW71qSJQ4KsL/fGwU8U=;
        b=PYir7/BCVR35nnrKm6U1S1nZJq79AV7kLnmNz1crIwjOKVwg6UL6x8Id4G9qYcDey8
         w+lM2AzkMnJia6hdFsViwT3I7o1D4vZQcnlIC5GJLEA8zmAxANqQAPNH8n9qyu2o87Ja
         QicC3SCF735BEeqNmXtTBJD4dMvFwTegHYGp0WGOgeqRhWxvEcq+xlXZPzy5wVCj76lA
         2iggcdFBlzBSwlgcX5ZlfSFb/brXWSqrxFb5nT3bm2JwvLKxmohf2xz2ARAUE+NieTvf
         xSCjhO9AHUGo8/mSkvHiJvJvom5I4E08DbONz/cFRg60sMjToNJhUz9NJQhEHESIZbBF
         59UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792103066; x=1792707866; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JsHIw7j65xDVOcoDPikKv7uu3ebdMMVU+ZxDmQjoXQw=;
        b=eatGLZ1AkoVbXnXQdacqidMYMM+AnC7mrJ5iXHKfFHuP3kt0ZVez1ReUPOVVqoyTxZ
         A9hu8eVjCkWd7XJz0u+NOhDTAU12AvKItrHAPxM0z6TOVzIpZg9+JK6JZR/4XSMoF+gp
         Q2A4Lg9Fu2u4SG8gP5WHgZm2ndXNfl+N9m6EZFwFTG4H4iio5BS6mkDCe8biTV6NVm4j
         uONFOtVH+RUPj45EdPEz0OMAMyPjYbZRrCBO8CjfSPKjtbIQKodEGnXFeUeAs9RnN2y0
         Xpt50h6a5hByIiXAkFi5QumsS+HxCakADE6ev1yZTbdOwyVfzigz1cOlMSClL60fnnCN
         1Yjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792103066; x=1792707866;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JsHIw7j65xDVOcoDPikKv7uu3ebdMMVU+ZxDmQjoXQw=;
        b=eK1aE2lSbU3q5JbL8xGkjjygDdI0/MKuChvCsT+UTIHU6thT91jbq0DvK8cOKcBEOR
         LFiOGLlWNqRxTyHG0Dbr9kL0KbrKkycIxk0uJpV4QyW9sMcsif+8NLO+sgKqpIrYt16h
         jmbGWEuvFdzMaV6YAO/+ohLhNL99UaRaoZD51CSiMB90UFrXEMsvpflI9LrSZ/IqwFLe
         YcuX0USl2JkMFv9lsFWxGL9nfhbM28ro+AaaYcJ8V8ebg1+0iDwgRkhowUhP+MttRIu4
         zWMvAnoVLCX8/m1LsPhrrvCAMlXdsLkrnLUvzy14m+T5yg07glhm17ulTAghJWBmiXgm
         s2LQ==
X-Forwarded-Encrypted: i=1; AKwUvByv1GxmOYT3TgyyR1dX5VbBqTV/+g5F+5S/UlCg0aGGlCkUoahvSWRXG3EXddiwuy38JA8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmpE+omzLjnVEJCVMdU6rRIZVQmpIAbLEUdD4nwwV6m9QzSjJZ
	UM59Ovsx9Juyf1mBhHO6K2ExPmmu8T0YZWpBtgmzmnn5aSjAkLZxYW+YP7ak+ONPWE1ivhnMhOO
	JmduYJu3k5yCxP+mv05uMU+/IMIl6zEnBl3AjDBZJ
X-Gm-Gg: AYBFou1iRVkleN1YawuOYRDHcBzgs+vaaffQBOauqG23ol7vXtNGptOqVL8wH7FJ8iC
	R5Tk/48dYs7nLYhJJxZ0LjBegpbJJub78Cm/ADJpb9zIBhuMeGWc4K/QZhNKOBBxp/Rq9k8VnVx
	f2Xgh2qiwgcdkXXyOraNaRoenPPlkg9nixi1f1Qo1p3CYv3FDTv1Am0Oi8aQrEz5yc2ShZEpQ1S
	87yP38aUupFe/z3OaYySZDS0YX1xebJupo1+UDwqUS+rw+KFFDBf0CxmUsGxJyuGSVCvrj5L3EU
	ncslU4VtqOO7du50VKpL7UMDIxoXmbvb/FZETzmP/tBFUwz/rJUca1k=
X-Received: by 2002:a05:622a:1648:b0:530:2f98:cebb with SMTP id
 d75a77b69052e-5362b40cdc6mr3161581cf.11.1792103065023; Thu, 15 Oct 2026
 15:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-21-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-21-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Oct 2026 15:24:10 -0700
X-Gm-Features: AclHuK8DXmxx-rfYkJXFdOtH4DbmnHj5hrHQbPjPUCKI-95-Z3_uO0rgyPy3uHg
Message-ID: <CALMp9eTF2NBYafgbRCfo=aEcTyC1DLB4gVpPM=rZd_zhqSuzQQ@mail.gmail.com>
Subject: Re: [PATCH v3 20/27] KVM: x86: Add KVM_REQ_MMU_SYNC_ALL_ROOTS
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Add a new x86 request to sync all roots, current and previous. This will
> be used when syncing the shadow NPTs on nested VMRUN when an ASID flush
> (or new ASID) is requested by L1, as all physical translations in all
> roots should be sync'd (since shadow mappings are not tagged with an
> ASID).
>
> Refactor syncing all roots (currently only done by
> kvm_vcpu_flush_tlb_guest()) to a helper, and use it to handle the
> request.
>
> Clear KVM_REQ_MMU_SYNC when handling KVM_REQ_MMU_SYNC_ALL_ROOTS as the
> latter is a superset. Do not do so inside kvm_mmu_sync_all_roots(), to
> avoid any subtle behavioral changes from kvm_vcpu_flush_tlb_guest()
> clearing KVM_REQ_MMU_SYNC. It makes sense to always clear it when
> syncing the MMU, but there might be weird dependencies on the sync only
> happening before the actual vCPU run, and kvm_vcpu_flush_tlb_guest() is
> called in other code paths than handling KVM_REQ_TLB_FLUSH_GUEST before
> vCPU run.
>
> No functional change intended.
>
> Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
