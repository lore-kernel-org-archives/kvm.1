Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C357CB640
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 02:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776305022; cv=none; b=kJEijE/38uRr2+IoJHLs9myJd3oPkmeTu4q11Xx92wPHxKNU6eFWEg/VZxfzmDW4weKTmRlhNfbkjz2rawqoXBJCKvG3TI5rpMnkO27McIxmtrsj9A04cHFBgG1WMV0wGNvBohJFCaSXTHMpKebsInMeGiOoJ07zKF8XZ5DORns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776305022; c=relaxed/simple;
	bh=xCrBfjScH2f9mae8zavMHEbT0JkVkjwomX/Z67ngiu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QLN6PzpulqT1OuBrSHJks8bKuzcMSNjmdf8iGrK2pNmzZwfyrzREKhYnPuOjGTPi8lcgQNu4gr8pBiqLIDikjWqbtBiwox1kcx8NZf20hb/djN1tTCUARHSzaG/nl9GyUtzVXrBI1Z1bh1u2oJTLXuEVfisqeDaE7gXO3zG1q5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/FU7L2B; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/FU7L2B"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so4384604a91.3
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 19:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776305021; x=1776909821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCrBfjScH2f9mae8zavMHEbT0JkVkjwomX/Z67ngiu0=;
        b=a/FU7L2Ba+fCOq1ls3qEJASWE+Vu89IebZTkp1NK39+5pjgT9t7jGoEc+s5nVXItQH
         PkQ6Lvjqv8SQzZP01ScXLgLoKxHyqatdJYnwlPKwRhMEzFh9E+9VxQTXqk3JD1haW7Gu
         ImFFlVqpXHTi/Bbk0ULgv8ZcXA+l9nJPCEO4wM82jAyusgDoTa5mgsVn0Z2TjP255Zsh
         GCBIFCX9Mx4X7xczuX+Re1b5ITKcITcoqDh0xw+JYgvTywdXS90BYz5dMxgStprJ/WH1
         AyrnVwPQvrQrB9GbO2aHlZP+0YiXdcbp5AQ0MMbzq7hN55t3m+MJ3NOr47SZDg8ndFQr
         Cxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776305021; x=1776909821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xCrBfjScH2f9mae8zavMHEbT0JkVkjwomX/Z67ngiu0=;
        b=lUsu2CY+re90veIqUOkffQEJf6T7mLw3SsQE+pcxnbNGEYjSpO++3TfP5E0MzKFMbL
         OakJP+eSfv5JSBm6dzhbk9SG2azd42yFbV71puWBBTeyw2eF5CkpjKhR9n3ThmuE/9wx
         M+nD1dXcXUwH/x+F/3nikkpbLmWQYJ98EBlwmS4QO5/aHqqim2sgOAFurf2+CfgrbjQP
         jE6U1R9N8U4UrmN+f1iylD7OtPCRlUPtVCsTkY1llYVrZkvhCF5OIIZDirH4ZJv9Q8OG
         jmEtbazAP0g4RQoSNDiL+fIY84Qn316glfeP6vopkGljJGOB1WbQB+1y2xfoVONoTrbN
         gsaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/b4jS5humw0WaddKwPK1V0WqYIyN7/H1RNv4GWzZOxDjYBnkuJa9xM7ci6pC795nnWSvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAArnU1vZcdyWCGtshWZ8D5Ig8WvsbQg/EQxSKgbZFqGHMAY1q
	EGt20EUdbMgAjYTYpd4iY7essDVmLuvhv7+FYqz5+WFmWp/GFE3OfncH
X-Gm-Gg: AeBDieu0S5HmqVHNdkxW6dz1XsINAgv3sId+VQCuxfHZWJkMDDwTwqRPnbaXYFDyFG4
	9+tvzcNFtQ1+G2ddvsR8RotI4ZZQ7nZRItQ9v0VajtM0VrpFkon+Nk8NgaS6+rLH1iUZuiySzdK
	GBhJyBbDt8pKVADh8NrqDLVCzcJwdW1FdSfJwSyQgH6AqVUmkVcp+T4TsF4WP/S/Mg7IQUFzI7p
	z1x/67o3qa6TjU+h+V9nM4DwSndoTvfwf4Gb1CfJeJkyktkUlHmQxHOj16CBIz0yEiQfMhzBFxp
	MUms2bJmEswLr+fSFjE2swosMw5ip8CL6Oid7IPfMkmhZj6W/YB0l/uf3Vt8Fz/CMp3GT3M5uyv
	KOIjYBPp5iWsuH+GRt1dEqaTF5RKi8F2MQhDKIGSTVtsq8QTMwa3mKRVqza82h7XuCaVH2IdShw
	MxdZtp/oG6GG56Bo9pZTc5HTzpBAjhR0koXSAeeQfPnoJlzTjpfN6t9AQd
X-Received: by 2002:a17:90a:2c85:b0:35e:58d3:3284 with SMTP id 98e67ed59e1d1-35e58d3349cmr10186008a91.9.1776305021069;
        Wed, 15 Apr 2026 19:03:41 -0700 (PDT)
Received: from lwfone-System-Product-Name.lan ([112.28.134.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fce824122sm2306348a91.2.2026.04.15.19.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 19:03:40 -0700 (PDT)
From: Liu Wenfei <liuwf0302@gmail.com>
To: ben.horgan@arm.com
Cc: julien.thierry.kdev@gmail.com,
	kvm@vger.kernel.org,
	will@kernel.org,
	Liu Wenfei <liuwf0302@gmail.com>
Subject: Re: [PATCH v3 0/3] Add GDB remote debug stub for x86 and arm64
Date: Thu, 16 Apr 2026 10:03:00 +0800
Message-Id: <20260416020300.854742-1-liuwf0302@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401042034.755639-1-liuwf0302@gmail.com>
References: <20260401042034.755639-1-liuwf0302@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Ping. Any feedback on this series would be appreciated.

Thanks,
Liu Wenfei
