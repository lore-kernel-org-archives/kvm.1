Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF4A4ACC78
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999651; cv=none; b=XhJB2lV983j5VYpkoPp76Fnxf9jPfA7gyRj/xv5/4qvrsUwpk+bHtowWNEZww8vsfjOeee13kHBbJfd79xh4/GErzfcZUT0dNdaMPWfrgBOfqImgtaWUTVqKA5NDFNaHJkDV6GjTnewqNzv3da6JaVFvhPcvVTJtx8pjU2EBWZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999651; c=relaxed/simple;
	bh=l74fNDk6VO8vPprQl+zeIl7U2mcronWS4nPqTAUnEVg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kHSXhG7QYHbK1FySd3C7Nk7pI1BlOaaWP9t3eo/vs5u74FJqZyYYEX8dfAGF1RvF+wWjRW9L8yWEketBUXMWAsCXDv2RgDuL2+B6KJPpJIRqggdDq6PbVI170jy6mLIyyayFQD3C51snXMhJuw1oIXJGfe5ljx3DrSrKF6N0OSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TQ4SqJXN; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TQ4SqJXN"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8679cfe5019so4381387b3a.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999649; x=1790604449; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GyNDJX3fIEdqZwMfzP/6YwVAKyII5CaZgMpV7trI7WI=;
        b=TQ4SqJXNZoYFTtg9QNA15/JLKCoTbgABf63jL5uoYH+coE2aLf9qpvWn07T7ry7RQT
         iIDlv3UpTzZ4HgKY3MtPKud7F2Y3nxWkddAuDNWq9Hlt0xQeq6KV6b738ZqnTdFMEQVF
         prFtRYKUNut+TDqUa3AIo7/7pqNBTbbSeGJyPsvAf+EaZtJtkuqwUq9DMCKytaJNn+Dk
         sqG9bp7XV60KZ0zOz7950Dzr1gGIz1ZzBaqKg4oaaYSv60hQI9VB4EWMvBHmckYl3t3E
         pR7nbZYnQAzhDir2wQxcLJJPxJxlvORHdZE6bSS6wxqpMRAn93wWSK34yR6BnEeaPZQS
         UsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999649; x=1790604449;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GyNDJX3fIEdqZwMfzP/6YwVAKyII5CaZgMpV7trI7WI=;
        b=z0CrYsM4cL7fegllv1hdVX8E/hcew3ZA0zo6o1kuMocqu711OQwMefvOHbuqMowogk
         bsauB5CeSm+4owyEuCttSb1lAFHtQaTkMC8E1FYUMU2GwldsLiRtoXAsUxlLB05HM3Hz
         MMoEYg2n/go966ikyCGasN6bR6DJgv5YepeGOACprGMMN3+e5YryjEtF2HEEIeEp6sBu
         QG4NsS+PIxXpBzyoAUG5PQUjeSTz9mL+S0gUqsG1+bAiTZt+IXGfLVv0v94ahWWYFf5N
         JuFSVVB7xtAQ+pvtBgpiepuMpeIShE7Dz+bXp/Pzm9xO7KRCYNb3YbUbSkd9K6bXxe8P
         Vs4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxM+RMhR+h7Cb95njHB1MpQpzz3rrbhnrwCFpg8Cup4jJG07lJRdqUWi4NteJrTZ94btPA=@vger.kernel.org
X-Gm-Message-State: AFuF++ml6u8yzHVSE0gW62I4ObM6MbbSFe28pNnYpT7GQNYuNuisLw0v
	02lrYZj7cUrSh1N3UHsosL49W80GHM0hHBMf55tKBzcZkVnBYQprabHtiCkvibtSzyXP9j8NKzx
	BcUl/RQ==
X-Received: from pfw9.prod.google.com ([2002:a05:6a00:a269:b0:87b:6530:9518])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1c8b:b0:878:34d7:6977
 with SMTP id d2e1a72fcca58-87834d76c96mr7399999b3a.37.1789999648656; Mon, 21
 Sep 2026 07:07:28 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:05:34 -0700
In-Reply-To: <20260803170825.925561-4-hisamshar@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803170825.925561-4-hisamshar@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999928264.755166.909574492736686331.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: selftests: Replace ulong with unsigned long
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, 
	Hisam Mehboob <hisamshar@gmail.com>
Cc: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, 
	seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	shuah@kernel.org, aqibaf@amazon.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Fuad Tabba <fuad.tabba@linux.dev>
Content-Type: text/plain; charset="utf-8"

On Mon, 03 Aug 2026 22:08:28 +0500, Hisam Mehboob wrote:
> KVM selftests use the non-standard ulong alias in several files. glibc
> exposes the alias transitively through its headers, whereas musl does not,
> causing musl builds to fail with ulong undeclared.
> 
> Use unsigned long directly instead of depending on a libc-specific typedef.
> This also avoids adding a duplicate typedef to a shared tools header.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Replace ulong with unsigned long
      https://github.com/kvm-x86/linux/commit/5be2d20f9818

--
https://github.com/kvm-x86/linux/tree/next
