Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7101D331ECC
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 04:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785817865; cv=none; b=HhfZRrTMUKqNYTim5jRSVAPLJLsWikNQ1tTxbsqoSMIOgGkBZG0halDCiWNkeLe16RJiKzahBWa8cAGliulabEXXYvXRRAnZn5qYD2RGQj0XB2b9uioxWjSy1CrZ6MHvbOZa9lSxVmxe6FL3vfqKOAV+ut8dvynPwpWIeMfw8AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785817865; c=relaxed/simple;
	bh=KGTJ/FyRXR8JidJJnOWeIFkNrB7WqZ7CgklUiGF8c9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EhdLm57DVK2w2AOruKrb54obJ7GCkAXqDgBD4jB+p9F5rzImihyvjta2ubadXIgv/avsu0xnBam1d1vCp2+qzQJfiHReyZjhEg9T8jP6/cchMFEaH6RkP8pfnlhxkNttoDU8KPO5quVuWCArQi7+S9WOHMd7myA7FoelaRPjMyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1zSbQai; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1zSbQai"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc891373e0so45472955ad.2
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 21:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785817864; x=1786422664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KGTJ/FyRXR8JidJJnOWeIFkNrB7WqZ7CgklUiGF8c9c=;
        b=P1zSbQaimeaupM0kh3rz6fcL8nQv8/djuQ2rdC/els56LrkAJGf8Y9HL3gQkOilq/z
         pBpj+DkD6J+4R/gXZ6lLfPWKdPWNWUOUy+m7ztH5nbf2i7btX4Wvd5/v7brbLp0nh5cb
         8RRx4ja4yd628AhJc6P1chB3BR10efqgC6BSSH6Xmx1ZPX0Mj9522Vqi3vubD/IjAq9B
         gGg8E0H9YTBmM0ZSA7XO2k82t7MBrX0Y6tpuxaYMsh22mPGXoyiQek6QzNZW19LvToS+
         lmIS6RUI32Aa8QvR7okjWWOy81TZakC3upfOT7JXKLwwQj8Iutu6t3rZYa2MxaZNmKxc
         bCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785817864; x=1786422664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KGTJ/FyRXR8JidJJnOWeIFkNrB7WqZ7CgklUiGF8c9c=;
        b=HADgIJRIa90rvH+EhKq44O2Nwm2w9b0Itt5BdpqKDMkA+8TYQ26sobreD+Uxxt68Ib
         JaxKF1y5kge8ruftJEZH/cWM7LEU3a+T+JtkHjfCqw+0HgNCYOXw5si6jb0ULhU4BfjF
         NropE86sN6Q//CGCJ+g+SfDXfI6RYNw9sA70U2wXDuhOp1052daFRSTlnd5mnD2hCLtR
         vIIRQqHrBXx/7bLputdXB73xQ+vJFSpDQS0fOJ3rDR8QAIIrpCB/LlS43Ef53AeAzw1P
         4C0TOA6iMWuXK8IiGo2GfoNJdcsr8sdYgbN1ceSLWAcQ5YAFiK4x4LgTqkJ9YqVKS8Cu
         UlZA==
X-Forwarded-Encrypted: i=1; AHgh+Rq/lN8psBX7XDPeglZiCe5Ls7JQb5NvaLXZhUq1s7/VplW1t2Uuf+1mCaaHjg9Ou1YdVhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy99+S3byzbi91JyvJYTxdh60lWslNHoXGPUFzfJbdPmJifqb9D
	qQhOR/1YM0vlSJuID8SJWTtq0Zlh3kefH7RNM09YR9WnrAa5E2YMs2eL
X-Gm-Gg: AR+sD11eDvSWOrnh6wAcIkibTnIYAiV5GdltqVHv5fAjfm3jzG0Agd2T1TbAQGI+zZV
	JzwyO1sA0jaxcGuCHH+N12NYNi83iKXeQvNTRML277I4eGpxm/JYcAnupsicPYvpltXGKxOkd4X
	qIIExAMYZf/+7h4lBIFgNv513eY4B2u8Lxxt46XjE4UPGLDeZOWnOJEDvQ71dRUTDWOKh/zLUiG
	NOPTiTBKdl34hMAZGZQpFX9V7jEPoCCVt1Bx7m0O4FN4o3+jVU0O1vqvTiMd+n9nAUa9BSxQ1WI
	wowCIT93LULH4u5rhRtBRvdqNTNoZ+MI0YtTucD2cefDGUhayRtKUisKXFw1NWOwwaibdNpzp5S
	uS1AWHmlctISqDahJfYmcpjgDY79f/+UaVmeRWZgGgcms7EwYgbbxigGAMttHdpPF/Qsm6CtFhv
	G7jI8HjZErOG/JHROntbcWPA1Yh+sMirBXZWVGXit6Yqe1kw8qb0Z0JREVFt8tkXk=
X-Received: by 2002:a17:903:8c7:b0:2cc:741a:ff33 with SMTP id d9443c01a7336-2d05247217bmr123034885ad.43.1785817863428;
        Mon, 03 Aug 2026 21:31:03 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0ea21asm46196425ad.52.2026.08.03.21.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 21:31:03 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: stefanha@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] vhost/vsock: fix device IOTLB feature lifecycle
Date: Tue,  4 Aug 2026 12:30:46 +0800
Message-Id: <20260804043046.6109-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803231911-mutt-send-email-mst@kernel.org>
References: <20260730104857-mutt-send-email-mst@kernel.org>
 <20260731103414.1746316-1-physicalmtea@gmail.com>
 <20260803231911-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 03, 2026 at 11:19:30PM -0400, Michael S. Tsirkin wrote:
> pls do not post v2 as reply to v1. confuses tools. thanks!

Understood. Thanks for the reminder. I will resend the v2 patch set as a
new thread.
