Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8395427FAE
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 04:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785816400; cv=none; b=QzUFx5HqhTdSjQ1G1WFRb6G1lWFCUBJJALq6u+pa2cTxguQNxFvp8IXwoSKRH2k9ZIEyZoKK+iWab9NatPU8yRJdvF7i4KbV+nA3OEMd6PvB5KImaGHnHmXTgX1iYjJLjTcBMlbBnEd7tQGK0sfx3vOQiFVNucwT87U6Xuuv6ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785816400; c=relaxed/simple;
	bh=gMxPIHbTy7IeoHGRIMeUvkVaienL0v8BTLWTR483DeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CwHAScaOIGtW9qOfKnGDikFsuSNBtrfaxZdAq8K5l/4WoSSdQC6xOYRCdV8PPwB80kWh6dKspagSHZ70gwpu9UokPaG+ORwnlTXIaPm+0qOJHL6VHNJ2ZGfmMT4IocSTwlK2ius7pWkZrc3e6FniZP7s/NGxo704lFGCMljPyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJqhDgnM; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJqhDgnM"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3811f512167so4184369a91.3
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 21:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785816398; x=1786421198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gMxPIHbTy7IeoHGRIMeUvkVaienL0v8BTLWTR483DeY=;
        b=SJqhDgnMo9kq3Je+6ArDUI6ySA7G0xtR9UBFWi8ulnxY+SLIUFoTIX+G/PeUW/eCqT
         gJSR2wUadyfqgXDmYMmnbUm74fRhc7ENS0Y4ITE4RNHZN3YRoheVG11Pjk4ARYJNRta/
         z0xG2wYyvyBE7FQJxiXpYz5KPVVurDXIf1HIrMDNitCmZyjBXXykdosYgeeHEA4RR6tf
         z4FGXAAlTGLJLbqbvKMrRlL7DiGeODXO0GR8TwkTfRYNpZRpVi8MM60ZgA1kU05N020Z
         rMQQoB13L74ZMq16eE11WhN+k/H9S4zMnmpWdbKnvEmwB+h8Rg6MGfBgzLeqHQmnk/nL
         yZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785816398; x=1786421198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gMxPIHbTy7IeoHGRIMeUvkVaienL0v8BTLWTR483DeY=;
        b=ewHytRWaCsg5a+pwa2caOvslkzBQg3D7VDUtLuA+/nlfJhf9HR6MeNMprIOR75KSxZ
         tWtD2LweapXj5JDPYqxv2QHRo/8gzlV+nUClXCVy25a0ajed1FHUdJG0+mFK7uLnXgp5
         207KAPGIG/NExr5GA45CVtogF+jKanzWTlX8Xi5lm1WHvV17cZqC4TOet0yHjioRNQIg
         cDL5w/w3f1gcZ9kDSCEDDvdWyoRYC62fJmhS5PyoClS9AI0g7/EjLigpU1RHFkb2EAIu
         7Dbej9zrVzp5fGr394uaWX8FXlnOz3b1F6ayQenFeq+XXyCWJv9yzzN0qsbhCGBRBZDe
         THEA==
X-Forwarded-Encrypted: i=1; AHgh+RpK9OvGQZ4jENBnL5/F1R1f9p4U25GZHmjmbL2oirIUAP7Jfr3aC5+C89jLnMQAHGEM6mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBLnZ8HLOWgqi8IEuUwfPnjk14wX+2aJZOYzWjrwBvKUu76lRn
	AZowm1ftGPSYaZ0ARmDnOuIxsCMctTEUZoIZtSkh342kCykMPq1YwY5a
X-Gm-Gg: AR+sD12iohmlQsx2fJnYvBuEE4xpZc/nwZu9Rq9SeOsdQXwwvw0QDrASvVMgsfYHLMA
	UXSjSrIwKcviTuBhkCjMFN+U4vhyBmuKsEG/nJd+jJ1AzfJ/BVSS6ZAyH22dmXIjwVtlIyTwFjh
	u8ltq4NI2spCJoU2n1rRCpLG19YAS+Fa7XKIIXQbufGVZa7XmOBenKykKH36MRzDbvzWZ18m8aB
	AZ6vhy3tCWpMC1FXiszYA60NHFhk0STkvVmJhfoUOJ760G+B0Otpx0Zep84AnTwVzk3v3D0+jcr
	t5UyuRVXxrYEReOh2rfMTDp+QON7shZ1FD4yicJYQyiHi6mApVZ2+pxsIswgMWtgGmWY+Xx+FBk
	975r+iKeouW25Jgjg3B+AzKfp/+9O+5JJvk0v/RJi+bqvtI/FTW4xLTb8XZF+7UWzM1sqVV1bT1
	zU6mJp5y2in3SapH1QhTDaIv0d5DGNKpzrF1txXXkYjlAfcYRSiJz3tlppyw1W7pw=
X-Received: by 2002:a05:6a21:e58d:b0:3bf:6c08:fba4 with SMTP id adf61e73a8af0-3c92a8498b4mr14546407637.56.1785816397767;
        Mon, 03 Aug 2026 21:06:37 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153ddd7a33sm41102146eec.12.2026.08.03.21.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 21:06:37 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: michael.christie@oracle.com,
	jasowangio@gmail.com,
	pbonzoni@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	pbonzini@redhat.com
Subject: Re: [PATCH v2] vhost-scsi: flush backend after device ioctls
Date: Tue,  4 Aug 2026 12:06:19 +0800
Message-Id: <20260804040619.5569-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803232144-mutt-send-email-mst@kernel.org>
References: <20260721073639.1532488-1-physicalmtea@gmail.com>
 <20260724060919.1569170-1-physicalmtea@gmail.com>
 <20260803232144-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If you mean Mike's question on v1, I already answered it in:

<20260723105451.1563439-1-physicalmtea@gmail.com>

Thanks for the reminder. I'll put the changelog after `---` and post the next version as a new thread.
