Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FC74DEC10
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955060; cv=pass; b=B+jL/A5+7pdr32yByued5dsNNEeB3MTJ0Sh1tRBg/1dMerNUfgir+zTccL0qkmWJ5gu2KGGMUTimID6tazAkGBQNAhRIVu4oh/ovlBiXdRLRQnJtDaFlGB941yQNiEN9X25TxNANWymGqYB6FynLs/jIoCttdYNtfrPOHL/O5uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955060; c=relaxed/simple;
	bh=fs5RDQ985eGOdUMkYTIO1AkzMa4f/KMg1mJ+9inMXJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdkEbDrlTsICmNaxLzBMUzEARJ19kcQ+E2GmUmp84f8k0vPh+LC5Sr7HkHUvSfjiqi3uWr3/dEEXPBtquEsF/98RWqD3flioH1Yquqm5Vf8q/FADNL+u4Ni6jGc0anq5SCNQtVnbouNJpNUOVvB4jzW+K2SYtBtm0Pjh62xyXmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lraWVlnH; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lraWVlnH"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5ba429b64c5so7290e87.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 08:30:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790955056; cv=none;
        d=google.com; s=arc-20260327;
        b=QRmWqhA5el8miBll6OMnETM/0VH6kdoRmzFGw0Ia+ECzHBD9JBxtCkLkAZw8SeI3MP
         daK/kAD/oUiWfQK7dniT51lhineGbhGSwqQ5MsSplqGKPxrnn0khZc2s8giYWU4pdjT5
         LCRE4RtUMUcDKlHyxsXSB9pv8AlDOJ2HWry+HJUF9/jYyOss6zgPyPlkszHBmStvDJU2
         +fRj2B+CACNQh14wuG7JRHztjnhjE3wk4PGi9IGHPnjCuM0wBVxv5iWO/6+gb0TI01LM
         AaL/NaW66etxca23eCQXAZvqRALt2fZxW0MFB+DZ7FdKQOmDMuwz+jAblo6TJRW+Q/rK
         NyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TyT67JBWmU8a3Diw010Aiq6t7ByqroB1mQnZlP3DzI4=;
        fh=ZLkNZdfsw8FvbRfrg6aFTbRBibKoi5chvVh9uOH1QSI=;
        b=ZpZhZieXMaBqI1ZV6Kff1JuMWteuitDC/8Smn0TKIozLynrEc3JKOski3v2rCDz2qp
         Hpwe8kZ2jB+3ztKy1iXyUmCF4BH/fI2BjjBzyjB0+5uWcwdmoX/Cucf2JPTBlB/IIng7
         a0CNgqn9fRV1tCCFkXuE1c7BTsI2CRVnNDPb8qDVHehDILet3AlfARcowmdEgIT9vdKj
         q4lzLEMH8pYYwPISsh5w8UzSSdnxbikHNW9awGxfO+ux4lvGIt7hwW2gQe0YDR8tadX2
         OFeptZGPu4XqndH72IkzHEQtUHff9QwDVL9kg9qp3xkKGMPZbvOG239Jg2ND5VTqVmdr
         aFqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790955056; x=1791559856; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TyT67JBWmU8a3Diw010Aiq6t7ByqroB1mQnZlP3DzI4=;
        b=lraWVlnHTWnLzYvhUgmrjHmds6O2GIGVU24jii+X+UWOPPYcpiYQirlq9bGIW85lAa
         59aaGNKyagPML8CtUg40UoO+/QZjWD59n4K/XI9eh7BLT4eZN7pIFkVl7sC1uXpirLvG
         HJXMxsIN00fDxE5W6blLmGW+hzSF6WzsYJ5878Iad9CP5kyKipA4+R0x9q8TLrETvkcP
         woLpEvsD4OFvu+ldRdZHUPdasc8pU9XXOyrlox5lir1uhBvf62HmAnjeeMVpKdPp6K4A
         jUIF+ejQDXrH57A09yCmxrEAkxcztx1LR/81Kn+qmHFxT1tvU0VrADDTsCycIlksvDA5
         A+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955056; x=1791559856;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TyT67JBWmU8a3Diw010Aiq6t7ByqroB1mQnZlP3DzI4=;
        b=1+gx97OCKnNT7ZxbJl3AMtgM85y7CRFneruMli+NGXZ84FbTRPaMcrvObY2/OE54Fh
         zYUh7VFRQZa5jQM0JX9LwBqI5cfMur2RdOB5lp5XNYO+kfYOHADMdS5CiY+lK6+dzHRS
         YnmjpjlwnRhiFUKqAXwLRqK7m51s4Ih5myqLkWcxIpHs1Me7E5z4KX+nZumjHoUMlwj4
         tyKhHG5x2F1H7mAGigQOLdZZ7+HJ0AxZN3auGxfLtQv8OUbWkVnABtUP7BHAT1+jsxmm
         qcMPG1GRQM+EMw7fRgkN2mqdaLZXxZb2RAH6O25aFNh1+3J2ox9vDeYJYW7WAH68/eBz
         b5gA==
X-Forwarded-Encrypted: i=1; AKwUvBzGq6avLOR2iTP4asdoiJnUSqWLq/OtZHUNLhvsUURU4T3n/S1OoDl+kefWrxoxKQVDSmc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4KEdQlEb+Ck9uXJm/YJH1NYU5hFiPUhObePgLMPNBTOnxDMFp
	T2j6f8WIiMGSj8WsbujirC0T1MnyCqALak9pHI6DIz064rLPKC0euNuHUFZwT5XJzzs37zjg8OG
	LRxgVpT0wPxTZ8oqMmDpKNwitKYmRt2SNwB6QU+Sh
X-Gm-Gg: AYBFou3PceMbF8HRC7qZYsuDc0cZPHtVv/L5dBp+HVLkE0lENKt/Qpvv3BdNEjIGhM6
	jdQdxYBIYxiefQLEwYZzgSBEeErOoMpF2RiJELRjr+WAnOSI8APKcyRUGYKBPBtEUixfAJ7Z56a
	S7cKvuUYfN5UQkYqsTEsUKSX39X5yyP12t6cqX/DXVmyXP3CATCkjCq6y/U0CiJw1F83LBSGxpk
	9Sep1YdxadbyfpXMkwq+7VTXOgXqFLGZg1NmIKD+0WsA/di0E0gjSIx3sNLM43lPX3xk1pMA6VN
	PUZL+m4n3OpM8AJHrYaCj45zy0T0UDgBklQJyVi2MFgMo20YvtkuHehgAT03/bzPTQibC3NFrb1
	Fmp6Q0pjvt2v/kPfO9F3zZgTP
X-Received: by 2002:a05:6512:3b26:b0:5b8:d04b:a1be with SMTP id
 2adb3069b0e04-5bb7c91a8a0mr183008e87.2.1790955055657; Fri, 02 Oct 2026
 08:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001210703.1597150-1-suzuki.poulose@arm.com>
 <20261001210703.1597150-6-suzuki.poulose@arm.com> <CA+EHjTxtatPyGcyvEyR129cqUiAYcO_cxRVtwZO0ckZsOnD7TA@mail.gmail.com>
 <86se2o2rbs.wl-maz@kernel.org> <CA+EHjTwHuJ0u_TTP46zNFKFmBP124XHHLUVhkAUSyfhe92=41w@mail.gmail.com>
 <86pkxs2npx.wl-maz@kernel.org> <CA+EHjTy4rb+6z0bqh7sPqACES0EDpURdeoyiFGmdw3p0PENcOQ@mail.gmail.com>
 <86o6dc2ka1.wl-maz@kernel.org>
In-Reply-To: <86o6dc2ka1.wl-maz@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 2 Oct 2026 16:30:19 +0100
X-Gm-Features: AclHuK-WxuFGXDBt-i8aW4clYrHg0y_cefCod2ajVZ-nmk2Rl2Vmyq6bDATGZwQ
Message-ID: <CA+EHjTy9wTbjFpgvDOX9Xexw4jpx4uHMHM9ckXYZw8H0_QbAvQ@mail.gmail.com>
Subject: Re: [PATCH v21 05/23] KVM: arm64: Track the type of VM in kvm_arch
To: Marc Zyngier <maz@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com, sudeep.holla@arm.com, 
	jonathan.cameron@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Oct 2026 at 16:29, Marc Zyngier <maz@kernel.org> wrote:
...
> > I know this is a sketch, but just in case: that's inverted. The sync
> > only applies to non-protected pKVM VMs (EL2 ignores it for protected
> > ones), so it would be != VM_PKVM.
>
> See what I meant about this stuff being completely intractable? I
> still have no idea what it means! ;-)

Yeah... what is a `!= VM_PKVM` ?!

:D
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
