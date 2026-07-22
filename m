Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B05D273D6D
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 12:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784723635; cv=none; b=fg6wWGnXZH0EkwzPPEWI/0t+c+YvJaHfPtGFabQyFB0JN5mfhFj2ikj4ubXEJ194eflwMy3+YW8uDf9rphdkDR7aLFbk0xwSm9ilVPIjUsgUcUC2C6WZ2rQjLcCpnfh0hZxaL4xp55AK7pguVSCw9L1b43r0bVqgMThTY5s3Rtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784723635; c=relaxed/simple;
	bh=3d36uKCRaS6/IIOjkmtzpGmWZ1IFVmcVE5FcEMMWVfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kv37i8D+aHq+OZnYu5iztIqs2e9NfLK09kUiMFid9aWVvxmsn47R5cX0i1tw+ULtIXtjeoiFgD6Qw/n8qBaDyTaw4ryBrCcj67KROO5wsoUcP5JvSdc8sqwv1pKys5D6IBsF4NDA3lUDUlgElcdJ5raWkUKhCtKEokDDk5lbtJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0R083Ho; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0R083Ho"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cae1a3a744so93444195ad.3
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 05:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784723634; x=1785328434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QxIfKuOVaE3EcHJclM4dn0Mc9MrDfV6Rgh6T8FHUwMI=;
        b=e0R083HodLs/Ohidv7dCkeD438iz47RqZHFFCzlaiUAmgKU3lw+3p28EoiJIxzxqkP
         qFGMPEe9clhrY4tWB60nbhllHHCtgdjNFEb3MVCPrE8w3CI25Zs4x73yhE/a8rlJ5zEa
         YDC5JeACa4i6fTc/rFf5Dd8T0WDr8txsMGsQKBbefPOj4ygTGMc1yLCeMu2pYAR1wRrD
         famS62z2dULw3fckqU/pGedAqp4fuKDvIY9RCRobajbZj0xYm1275Kkv3wTKHJDdW0Dx
         kM87UCQLF1n3/louX5dtp8J1JwReJM1mK95AfMlFEeq5eYUcuvLy9DlX2C3o+mTobVL/
         p0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784723634; x=1785328434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QxIfKuOVaE3EcHJclM4dn0Mc9MrDfV6Rgh6T8FHUwMI=;
        b=BtTGvF8dgmhGA2AatnThlAi+XwsLylkIDk+ZNmA+/xcp5NrIbC7kCdRqUVWrhCCW0a
         HMuCS8BOlOjtzfFl1kfijsDr3xTDv3e/VEzi5LwYAZaV/vo6n1d1AxG+9oJOeAyPlVhs
         brQi65BlbvIy9deGenALLPqeviq6usED13fx8hCFMxFmpek+tM5Ampv+pT00XBSjf/Yx
         kIE5j10lwuwAitCY8ymM1XT4Ditynw94bh79Gud2XNscOc1huig3Co3ELGS1N/t7LhqN
         UUeTMQx+ZBmyw0jHx1m0Tr7GIXsqEcp7DYSeGlOilDQD/zDgGG1XOBVGgu3zKklNz3E5
         xxJg==
X-Forwarded-Encrypted: i=1; AHgh+Rqa5qXP2k8aCIOdHIzY8KzHKyiwgaU6/2QW0HOmsoLfvk9ihE41p0BMmtlhj6GpDb1hD18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpUGFeWJQ3khC8i1PNd3K3+lZB8/MLW9sihLM7ZA4p0wW7aTUY
	7W/gR85w0HOteATLg1LNU0yAm6+gnenAxqGRSCgg5qybHuALpz9bGja5
X-Gm-Gg: AR+sD10Sln2XdiimQF83pECVrMIwm/RIuP4J9j4xa9bh/Yg8wTee34UVSCSYazcDyNW
	lYWAn8C2CVjNWRMf5yMJjqklAtwexpSpqsJNlDspW3TB0jHVR99nZ8VqVB5WcF8R8tT3wIallXd
	sMoi+IR8H4eEi7flu+WTgrHO/lUdnuVWAQhCdVYGtEmG0+FFrAg9QPcAF60922O7MLk50Jt/nTj
	CRkCRxlYM4xBqVneB8DNLnpCbi6KH0awv+We2H5YUbrKSVv8os/PbYPin1za3oOUXgRsVHBwvlf
	nHfWJ1ChY1qxuwKB9HTp514YanPm8NHBgnoUQylaxBdGKTFrLPJrkBuJf142zku6DAj0+Wgs5mh
	H8KMcHdvzqL5RVpOA7JQc4L1qBegXzVVi49WbvGgWGG5nNbwPaUXSrT+8KsvmHcrNV7t8oVP6YN
	5ObK+6EBTYU1kSuySfYIOC
X-Received: by 2002:a17:902:e548:b0:2c8:4c29:afeb with SMTP id d9443c01a7336-2cf348213a8mr249494965ad.8.1784723633958;
        Wed, 22 Jul 2026 05:33:53 -0700 (PDT)
Received: from cyh-System-Product-Name.. ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf96ac33eesm7214735ad.72.2026.07.22.05.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 05:33:53 -0700 (PDT)
From: "Yuhang.chen" <yhchen312@gmail.com>
To: bigeasy@linutronix.de
Cc: anup@brainfault.org,
	atish.patra@linux.dev,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	zhouquan@iscas.ac.cn,
	"Yuhang . chen" <yhchen312@gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Use raw_spinlock for VMID update critical section
Date: Wed, 22 Jul 2026 20:33:50 +0800
Message-Id: <20260722123350.3697232-1-yhchen312@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717065137.FQ5Ax2W-@linutronix.de>
References: <20260717065137.FQ5Ax2W-@linutronix.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sebastian,

thanks for having a look.

On 2026-07-17 06:51:37 [+0000], Sebastian Andrzej Siewior wrote:
> Here you state _why_ it must not be preempted. What would be the worst
> that could happen.

The worst case is an unbounded hold of vmid_lock that stalls guest entry
system-wide. On rollover the section bumps vmid_version and then broadcasts
a guest-TLB flush via on_each_cpu_mask(..., wait=1) before assigning a
fresh VMID. Under PREEMPT_RT a plain spinlock_t is preemptible, so the
holder could be scheduled out while still waiting for that broadcast flush
to finish and keep vmid_lock held for an unbounded scheduling delay; every
other vCPU reaching the VMID-(re)assignment path on its way into the guest
would then block on the lock. The rollover is otherwise a short critical
section (a version bump plus one IPI), so keeping it non-preemptible with
raw_spinlock_t bounds its hold time.

I'll fold that into the commit log.

> That part starting with "Convert" belongs into into a new line.

Will fix in v2.

I'll send v2 with both changes.

  Yuhang
