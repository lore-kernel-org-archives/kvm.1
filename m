Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27591519B4
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643773; cv=pass; b=FMFKBC2PJGRgMuGqWBpM80rAlwIurLIjYjIKcBecaaE60C4jy2ddTh/zSYCyLd1ZzGSmNMniVHX6bxeqE56+k7XIGK7ZNJFdCq794cF67SmF2hD0CmIdsxuw4oX1KGoyj/aFLvY4GV9cwsCnYAkrhgtnURsLR9Wry21CBeKDivs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643773; c=relaxed/simple;
	bh=dCPhlmiJDHCE8ijcIhgHxZuwHayfeLme8LCV22wQekE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4fJ5rXZtmAKB5ec2ufOmXsy6n+jYzB8KrxzNyMYZGwu52parzjnsILRfBStlNxl3piKYUzN/3OUCGaiR5nCzHhdLRYyoO8/Fjfpog2Fexwx+ApTCAvlIK4712sL1xzPYN/pJOfOpsbr+Ec/Bovod9zLD6nNRCNTa6Vr+35raoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fQnWyI0W; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQnWyI0W"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c998fd549a8so238581a12.2
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 17:36:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783643771; cv=none;
        d=google.com; s=arc-20260327;
        b=fuLeLNl1w5pp4ikoxicDddv6TsXUyxMlawRt5xOLEXGMG8T+pna3n6Yhd4z9aena8r
         lPJLkqsiOYx4P8ixHqsF63K5u7SMspvzEMHxSFXioRnnr1Cgqe9QO7CJY8BN3oUnd76E
         IXiicbQORmBxmZW8CLVr2ociw4me2wTmv7rtO9jwxlM2WxNFX/bYX1JokvyZx6V3Haj7
         SnH1CeE0taUecXnj7iCnlBW1JDvkJlGc6B7JhegaHDlMQHs4v+P6Pa60kMk7vncQX5Fp
         0GTL2M62ZLU/2FNzfYYfujFw3FNtA3/TIk97909YbKh5V12qSUf6qeStYw/RLa5p0vjs
         kLZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=SUfyP5boq2kCQjZz178vST51XCmfalTtMLomsdYniQ4=;
        fh=wfw0hEOlkq3EUE6azXKmcRqOiVR9wJZgs69aE8Vkuuc=;
        b=mDwQJP9F+QLNhEoVs9xvEC7J4062PwOZdH5lxqjxZCqq1Vsf6/IjVFpH46L1UAKTXp
         V9vaGPFzITec27qQ5CMofVKHmkN4DI1+oZqlDt36VxwduzfJ9k9DS7yyoCWdmqt30xdf
         +tON27xjTY7ZySxXmD1Fw0tunwqK3Fw4i0JQdnUw2YqL+u/XCDZcy2SJPoeIW2qodvZ9
         2la2cv5fLkeXacxINdNN8wZPcz+0w7esTu/hInozqUW+LmDgYqXE/vi59MOa6FsUP2KR
         GbZHhH5nbsqGj2eI6t/g72EwOQN4E1DD8SgZpsjGYGU83/97rMjCA59+nGd0ZM6hwAZ4
         aCnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783643771; x=1784248571; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SUfyP5boq2kCQjZz178vST51XCmfalTtMLomsdYniQ4=;
        b=fQnWyI0Waxuvn0UQKUOz8RpaVbCYtj4bdEAt92xXUUOP+ok8O7u1aHvSGw+2ZT9z4p
         A/JVMgaUEDjQdLKzr3+aeFEvi7mmXed348ykAytvzNROn2zr18xtkxLdviq1RNqOxA7e
         uTlk8SvFKV/XA3GDjfbHxZW2buBWzqKrJiixsNfqKsPULhYsWw65TQAYc46GnPCCcjiN
         7zPQ7WPikS17GhCjObEsGbI+gVvvIZq8Bl8LLawGazPtvFQLPGACXDdJvRy674avrd+3
         0vUfiU94A/oGSfyIjUHReXTtNT+rp8u7HnZu3a7Rno4IfQ2zbnDl6Y3UOPpqye4AkA/2
         xA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783643771; x=1784248571;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SUfyP5boq2kCQjZz178vST51XCmfalTtMLomsdYniQ4=;
        b=PDtKbb0NmwV6oRV45/6W88oWiQk5ZxcGwt5Kvd/Hlpb/jkLjNiZ1DeYM1MsVRjH7Wi
         JZF+l0TWOAvwyF9jhB3l5jNLnypvHqhHM6CEutnZbA+CKuSApF1RJ+b51BqUwNSVwB7v
         6AAaOldZkGo5NP83BWy+AiheaMNL98/W7hg8tCo89rfCxORzvorjFidDbbbeUDUUXbIZ
         M+OlsoE47Mc/v/QBvQ9v8NlHTFfu+lXqcUjAOxk/f8F8Bz81seBDMLyvHqudfpE/2mmb
         lrgXmdbFlHXBO3hdp8AV07Wqtzhix6pjsoY3wNJXRwgHFmFsx+3TVRYWyGnKl0v45udT
         9TSw==
X-Gm-Message-State: AOJu0YweeaL0QTumizQFHa/RnjqadtUAWAi6nvKto4SOFQRhldVexlAO
	XmzkChKm0Z0R2Igqu07yDeq3H8lbEEe4r6ip7L3B9l5Ued/j3I+i39TGitN8AmMC2FFrh6AkWzX
	SmNOa0XgVeJz81NZ5AUJsvjU4S5d6TnesQHujKfdv
X-Gm-Gg: AfdE7cmk4Mbqvq8hQWkR9a/FlscZUrwcd3hL65n3CQCjd99D9Q3U6pfZyFijdH+f1wx
	3eiEnEHwS5EAMeeJcpQGah52kUkli88N1MLmrlpQafIkRBin6zhG34sSDCjOSSbh5zH35eTUkS1
	0KpqsAlPWqtAg/+9Q6j7BefOMHz0GhOy30o+HLLvuaR6q/XjPOBBFjtr61gqqMq1z4BD6MkvcO1
	FDpdXiKptMGdumLgNyKzzsigBVaUQIS89lEUeTghMPr0t8MctHq8zeYjJu0gcCbvaA26xQKfksX
	yFjo1OG8VMLZrrdHmnMxvAOETHzzVYqi31/ZQe8Ib62IiYnyRp5OvxxCnsSxZPs7OwZPzw==
X-Received: by 2002:a05:6a21:4a89:b0:3b4:7b2a:6a0a with SMTP id
 adf61e73a8af0-3c0bd206afdmr11788982637.35.1783643770646; Thu, 09 Jul 2026
 17:36:10 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 17:36:09 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 17:36:09 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260709204948.1988414-14-seanjc@google.com>
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-14-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Jul 2026 17:36:09 -0700
X-Gm-Features: AVVi8CeQhyuPLeRKD80vxYdrK4mcpd7qGJg5HOLv6PBjBl6SOz14fTSOiZKUj6A
Message-ID: <CAEvNRgGz4hWw+p90JPgmP29dMKjVcamfH57Hz=k15VYEypSfEQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/18] KVM: guest_memfd: Pass GPA, not GFN, to
 prepare() hook
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Pass a GPA instead of a GFN to kvm_arch_gmem_prepare() so that the GFN/GPA
> can be made optional in the future, i.e. so that guest_memfd can pass
> INVALID_GPA.  This will allow reworking the hook into a general .convert()

How about defining a INVALID_GFN instead of using gpa just so
INVALID_GPA can be passed? The SNP side takes a gfn, so it seems like
the 2 PAGE_SHIFTs are extra work.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

> hook, i.e. so that it can be used for both "make private" and "make shared"
> operations, at which point guest_memfd may not have a corresponding GFN,
> e.g. when converting memory back to a shared state when a folio is freed.
>
> Opportunistically swap the ordering of @pfn and @gpa params for
> kvm_x86_ops.gmem_prepare() to match that of kvm_arch_gmem_prepare().
>
> No functional change intended.
>
>
> [...snip...]
>
