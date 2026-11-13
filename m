Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577712;
	b=QRoP4Ky9lwKJzW3XHAzi+Hdcji6OZ/1Fz1gs6NxnT6yGrSKJdV7/kPdzE0SVexhFOJUz
	 9l7cUMfk8YuOV90SbubJk0mDuBC2hH/fcsC/vVXXR9AVgiGvgd1XcGTtSWgRblmSm/UGG
	 UxPjgMkHQ8Oy+4DmX1E//kAxzfwes8qrWNiLuLEX1dHiG4wPITRUNHkR/4WlAjbbaOVgF
	 bq+hMQgfp9EkywIdQVpWIVAasVI23Vi7IA1hgueUyuJzt9oyBiTcdSOWqlH24hd6kR2Ep
	 SBeGS71/xnZ2EBqXWBi/Hl577tTa8w+QGHyAe6q3LAac4oZJPlO3rOqBr41Ur3RiAvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ztCVLR4oyaDQoUYiuEt0cXFwIryM0p3L1XILtPiMVVg=;
	b=IWGlPh6VQAOUIC52XoDzDsxkwvzmOR+wXzua0RhTmVAaCmjAAPiBWgmZlOX7cZh6fXNO
	 fplkDVN5Z2LJIXr2fvWxcftjELZWsdCQl66VCsaRzZX50ikIGz3OHU44Gom9At77kgirc
	 c+3zSFRBvHcH+qISv2HOu8PlYow9DZpszJBko6aIBQo/tsdCSaNsmYtVjB5KT9O/DrFlE
	 stGdGblEzcCRWPFGauHVFv9Q33GGgsJinJIdcORSzTK/O5ZnXVnIkxmGDEqfoMdTBBwlI
	 Gyk0WOO4cuyhSYZ6o+BwtO3lwfGbnlOTyddl8nbHJcdFa/XUfe45qPm7Zrw0qWu5EmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WoPGrUwA;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C61606A33E
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6C61606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WoPGrUwA
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2eaae62796dso10073575ad.0
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577711; x=1795182511; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ztCVLR4oyaDQoUYiuEt0cXFwIryM0p3L1XILtPiMVVg=;
        b=WoPGrUwALD60jdt9loWZSiEzDaT80XiwIJw3nW0b8Zv8mLkSpOQ/Gix/g9y5T3rCLC
         9wG6W/WA0rZ9Kg9uxfDW1FnsBtwfd3nM5jc7AkgjJxZd+U/klfOtKTo1n3dAMGUig8h4
         liBwwRsekr/EmTViFqJh7VbuOMRRyF4QS/SVd1giy9cXun2loR6GP4WKDjeYYYYE2VkB
         /F6Oh/v3eWUVwttq31SuF1zpLxRPKqMTYct2DH2y60yZVI4FzdDfUNzO6RFr11EOzqtW
         MzzVEnFBwf41JafsfwXP3W3hkQQMn89fSn9DxWRABy9W5dIfAdg5ApdaOfvWXN2iLrSG
         LCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577711; x=1795182511;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ztCVLR4oyaDQoUYiuEt0cXFwIryM0p3L1XILtPiMVVg=;
        b=gUiUPh0qaJJvoPg6zjnmlztIjlZJTcm2asewsmIynnOUwfJtsaqdWIMWFsyVn9VDuM
         xzgQt3lsycim7d/6UQISIA6QqfV9d6ofHv56jXOcT6uKuE/jZsVUkJvQdLQh4zo3kXoa
         DkA4EVICMbEX74ttzv8l6vDDjwZ/cIYFLeASAh6GisA5TvJdZmaVnIDQffSvJ0bm30p2
         ayMPw6WNo9WPt1bkjF/tILKY5YMNndPCN8zDEk+BL6otzBVBJ41iarPXERkpGOKIMRba
         FC0J8jpcdDcu4msD7YJ+Lz9TwXcQI5tcmBAKiZZKTwitLKk6MjNs4jjXC7z+e+LZj0rC
         lbbQ==
X-Gm-Message-State: APuU4Z8OmE1KOC5qTrSaWZN3FgcWlhgu06DrNGgyzqAT/zNhu9MA5raL
	zg88+VkXoq1Oiq/C4GO2pvrQH2aRAYZ2VyscoUUSACrBgZpL2ZmSlg2ahjYluI5i2aKH2gSd44D
	IW3SP0A==
X-Received: from plan2.prod.google.com ([2002:a17:903:4042:b0:2e9:6e08:e249])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:be05:b0:2ed:1350:59ff
 with SMTP id d9443c01a7336-2ee0d662901mr15170605ad.3.1794577710807; Fri, 13
 Nov 2026 05:48:30 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:24 -0800
In-Reply-To: <20261008062643.1183018-1-shivansh.dhiman@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261008062643.1183018-1-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441837420.82293.15548104733852212417.b4-ty@b4>
Subject: Re: [PATCH v2] KVM: SVM: Clear VMCB save area instead of entire VMCB
 on shutdown intercept
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, mingo@redhat.com, 
	Thomas Gleixner <tglx@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, thomas.lendacky@amd.com, 
	nikunj.dadhania@amd.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="utf-8"

On Thu, 08 Oct 2026 06:26:43 +0000, Shivansh Dhiman wrote:
> The AMD APM previously stated that after an intercepted shutdown, the
> entire VMCB state is undefined. In practice, only the save area is
> undefined and most of the control area remains valid. Revision 3.45 of
> the APM now makes this explicit:
> 
>   "After an intercepted shutdown, the VMCB control area is valid (with
>    the exception of offsets 60h, 61h, and 68h) and the VMCB state save
>    area is undefined."
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: SVM: Clear VMCB save area instead of entire VMCB on shutdown intercept
      https://github.com/kvm-x86/linux/commit/bdd05706f146

--
https://github.com/kvm-x86/linux/tree/next
