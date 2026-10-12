Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217374B95C1
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791833379; cv=pass; b=d96pVxCDEJriR4O7RViwqTyEsrT8LYpT9gz0L9IIKteeR69+RDscFAFoUr4nwEpUpxiUg0/FsonygoxVI8WgLd5Mi2TBGQN0uKZUD4UrFYOByGwHMeEZxYDgg6LAhH23tU0TqvR213nAJ0Kj/ot+LQQB1GOqWWIX8n1DCq/4aak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791833379; c=relaxed/simple;
	bh=aoPqNjug6jdHt00ush3qNX20F7lS1qZxd63aAzecos4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhVwqJRnPZoWR2CdTiQ90MePR+kzx0px5Yb3clFJIKmzfEh2+dbGlMGn3bKxj2JVW7QeBUj+NZAYh1OeztZeIC9oX3DJzfP4GAj6nat7RbsqZs4qn71+EO9AjwPoEgxzYwRLXF8ZgBcahTFJ0DP0UI9OmmlI3X49+MEwOEvg9Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Afe/3Zr4; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Afe/3Zr4"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso15145a12.1
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 12:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791833376; cv=none;
        d=google.com; s=arc-20260327;
        b=V7FyQkZBOsFQvQrZaCNqPRBYM7/r7fJdSyCkU6Pj3YNNghtrMC9kwiCgK7QPl2jnn3
         sr3iXKmGfjfZK195ieaDbXTS9Xc5GTLDOhIYkjS4o+js+RvldFlt8Wp4bN71Vpma6Bsb
         HlFzPwB4d9mKvki1edGns7kZnAYeCQHbf8xILI8fYnYWqa1O4x2YMs37gU2gj4NKhKw5
         FyswDEh1QTGCTJOkiB/TLE7D5khPJB76PRUaXalraiUqv2qoZg9mEQHwpLvpb37Aqhlm
         vMhU3nms0PLFNKA5bel2yI4qqbHiiSYiw56MwGlJiWli0DnaQWyba04/qpJ5zRnlOXJ5
         +OsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aoPqNjug6jdHt00ush3qNX20F7lS1qZxd63aAzecos4=;
        fh=yeX6vePwPO0OIuWIph1dgzE6YevBVO7sMZxy1Yocknk=;
        b=Ux0EfUpRd7Z+xaLRLiSiLYYBqfbYqBzUIhrAoNGE70SVGAl1AvyYBpmMln0dnqKV5/
         /ro+rlcopeV0eMzaQw17CfH2EbyExPprDHoSSJ+HO0OZWUGuY38yQCi1OShHyMuICDpT
         DVmUuzpar52gXWNgfnISBlphyVjf3QQ9ScILT3VlOqBzaa/aV+rlrTOSxMfwv2JBW5Ul
         w06A1r/jobaekAELSxXtYKz/vTSHG/Nw+9p6twSjyDR9evp4P2kz1UTc+5zZn/dkMyOI
         gevAVomEbLwcRVol8QdaQYM5f5Im1zKV8jQWAlbJK6MYUcm4ijFFF+WtsBRQ70/0DxXZ
         knPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791833376; x=1792438176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aoPqNjug6jdHt00ush3qNX20F7lS1qZxd63aAzecos4=;
        b=Afe/3Zr4ZBhFeXjfVNJcs5SlL8kH9Hf4n+lQ9CVzyQqXgqdq27opBUFIMFZdn2VRCP
         k7yVRUfPkGSbUSMqtxqRmmH8/OXpVZ4uXfJZAbeDOYPxQcJOEYAbB73gJxCGFQc8HJcs
         FK3N9Kez/I5hywoERU+iTFa9YoLWPiLEKMdnQn5Jzx6f6sTgvP9YHszAr8PWKlbGftEl
         s6RHPCMOr+ekjfOVGp3kfBSvmttbwYdICha4KSmjOVKRI2h34OQUMguffv7ogVewEae2
         3YXkRZ13tctZ9CZ3Itwje+mrr3IUm8TnsJEmcTshBjWKi/P4GNtJ10EcSfCDQ/3JtCPy
         HRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791833376; x=1792438176;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aoPqNjug6jdHt00ush3qNX20F7lS1qZxd63aAzecos4=;
        b=xzy73xy5ZUAJ6nbZKV3SoyLLYsX9Ff265QC72/WioJ05V3o8FgTO7R/n82hPFTC6p2
         518ELgmDfgKwI+Ovdhu5Vx8SDRLqE+wRJXqx3xwN28io5k4/pjfJ7U/oPQ3KqHInGiH7
         TKQb/GhNhVyzfUj2+rwYkmqpo9Z8tjpShf5il0aANhLwLxUSrGEv8JB5sxydXHPNLspq
         tdmZiMyioxKjISiKs3w0f8CRf2BxATwIFstb3ut/XNzxlFJVBzjFN0pwOUCxEOI83uty
         xaPTk7nU6LdU1rgEpL3jQok+AkxEG6WU+6yYedIl921q57mEWDkSFd+kbveonulUKT1m
         t5+A==
X-Gm-Message-State: AFq9FYJgoP2TspSOiF0/aO2f45Ufwj+LGrggEbIHBY/halN2LhnHwBgP
	A6KLWOnQoMilaXU1jVzfY52WrYNJjsm9LzoFG4XsngPf7A211WCGsidX20Nu1fs+xT8IKNEZvun
	+QbnEwrfkNsMGpq7nQWl2NT/kotrjj0Owgnr6P21g
X-Gm-Gg: AYBFou2vJ6FtOpBRlhTydHDCjXI217ZtWit6g4v/qESp9ndTUCcvWBqTUoDjOtj6woH
	ZaENyRH9tptLbDL/1yflKpZSpzR0AAwIBYmiHsNiM4katOnEOKqukBbuJjVMpTJqPe02S4gf3OR
	QNzYBdQBDKJcQQJNxx8+j6FWQHXndxhQvhihkhWRAKOj/B1jS4oc04WkXxtzmATz9kzF23IQxr9
	p8KNBrZ3ba7laexaxXq1lnEaACF+BblgSWOESjIgJ7+ljlRpljXHbKD19OlwVFmuroXg/UerpJM
	DXNsBppWP5hzUEb/5zNKX9QvC0WIrhQnGkgr5wLItGoJOaO26AQ9v64=
X-Received: by 2002:aa7:d58b:0:b0:6ae:188e:e119 with SMTP id
 4fb4d7f45d1cf-6b199a610c8mr109200a12.9.1791833375825; Mon, 12 Oct 2026
 12:29:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005192431.87317-1-hmushi@amazon.co.uk> <20261005192431.87317-2-hmushi@amazon.co.uk>
In-Reply-To: <20261005192431.87317-2-hmushi@amazon.co.uk>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 12 Oct 2026 12:29:24 -0700
X-Gm-Features: AclHuK_hh2UTJ_clCzObOqLEy25Uk0BI6IitQI982CcGkWt3YHwLApApzuL7Il4
Message-ID: <CALMp9eQB_FmUocuEf8hTYVVWoOTZCWzJ1LhHm__BaVoNX8wKMw@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: nVMX: Clear stale vmcs02 sync flag in free_nested()
To: Mushahid Hussain <hmushi@amazon.co.uk>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com, mushi.shar@gmail.com, 
	stable@vger.kernel.org, Todd Frederick <tfred@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 12:25=E2=80=AFPM Mushahid Hussain <hmushi@amazon.co.=
uk> wrote:
>
> free_nested() frees vmcs02 but leaves need_sync_vmcs02_to_vmcs12_rare
> set. The flag means that the rare guest fields of vmcs12 are valid
> only in vmcs02. After vmcs02 is freed the flag is wrong.
>
> L1 then executes VMXON and loads a vmcs12 with VMPTRLD. The flag is
> still set, so the first sync copies the rare fields from the new,
> never launched vmcs02 into vmcs12. This sets TR, LDTR, GDTR, IDTR,
> the segment registers and the FS/GS bases to zero in guest memory.
> set_current_vmptr() re-arms the other lazy flags at VMPTRLD. This
> flag has no such point, so VMXOFF is the place to clear it.
>
> A nested Hyper-V follows this sequence when it resumes from
> hibernation. It executes VMXOFF before hibernation. On resume, it
> reloads the VMCS images that winresume restored from the hiberfile.
> VM-entry fails with exit reason 0x80000021 (invalid guest state) and
> the guest hypervisor resets the machine. vmx_leave_nested() also goes
> through free_nested(), so KVM_SET_NESTED_STATE takes the same path.
>
> Clear the flag together with the other nested state.
>
> Fixes: 7952d769c29c ("KVM: nVMX: Sync rarely accessed guest fields only w=
hen needed")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5.1
> Signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>
Reviewed-by: Jim Mattson <jmattson@google.com>
