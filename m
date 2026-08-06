Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB7F3AC0DE
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979208; cv=none; b=mXxBy1oXZCyi4GrXYA0M5G/4frzNiMPAB2AdzYFaQYT9/+r4S2E/aE9JAXv4nMUQiP4BCgZwDBWXkdY+kTvwURHZ9giYo8NdOqL3f7n/fNSZ6lbILqV3Qq1JI6SLSm5HVL7osQ+geaHlh7W4z/Xa1LoGwGguIyxdwkMiJruY+yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979208; c=relaxed/simple;
	bh=pDhWKQAQpmDQGSN1gums3GOjJY3v7WMpe631+1JRx+k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=McAYqTryH/lwfvQlxfMA6sA8XM0Ib9cOdZCAFwVMrx/JHDH+Bi4Ao832YSiy12C2E18g1VHYklTXWpdVk8Z4zpLy9Qe9LccpbTrtUZd1+Wrz2ZOUq4HqmxS3ADUKoeCwJUn7xZNPmevqBgQey+A+oojYDn59mUcnLGD6mBjunJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD4PuFHu; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD4PuFHu"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-caf45fc5202so1510029a12.1
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 18:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785979206; x=1786584006; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pDhWKQAQpmDQGSN1gums3GOjJY3v7WMpe631+1JRx+k=;
        b=kD4PuFHuCQ4WlAeY61YTaewxUvA/aM747z/VlUqhhQeOXQbx9t0pl594cMlcxBL1s5
         Dxqc6oSmTKzAMDn56spHFS4W2o79MkNOrIeXaTH7PhJHCZh8nSfIAxv4wptIQJTSef5I
         pt6SJg4uZfKHCvIeJfiuopiMBHTV+iqA0+tR9+RY06MELbkXA+57fL1ibRrVqfglyrtH
         m+K2Bg01rQnbTgbe3fG0LEe4Y6HoWK0dYdt+x1Vj9mkfiPCKHBKQEEYPrxhWOM8Ts8cI
         9ytIUXKeJ0ou6RI7Y3lfG5wfmhU98pspuD5hGed2wM6XerUyZSAee8Jm/zjNxEFFey1V
         jDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785979206; x=1786584006;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pDhWKQAQpmDQGSN1gums3GOjJY3v7WMpe631+1JRx+k=;
        b=pdrUEePMM7+NxVVZXzaEunYDgBkqD8fArnBc5czTRm1M/I2atVEu3x5cbywYF6ee4J
         jcLQwubn+7tRKvOwrN4MBy7MvnEZz1zBQcpu4s8Y0tEPya2BdfyICt0YdWVwU8yNMsuC
         9IOz0igAmBcu61NJ/3YihSrHg1zj0OzBq51fFn3IBdn41L9SQetmT42hDjueL4Ucqxan
         Pc3++akCRUtG1JjKvWpdNEV+h/+q+XqcGJm/XucT8vHiLHJHINyxcrrDr+vUo8Bqfyo0
         KfWSKkD/OuXLUsB2R0KWIRfiwuXzQrntlzp63Nw6vVYLnkOBe2AJPBJosCZsqcanXwdF
         nkGQ==
X-Forwarded-Encrypted: i=1; AHgh+Rph0wqmwnNisLy5Exd/NBZAQQYckvXpzrri1/7rx47E45ZfYSIOzanP7+P+46H5APee+fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjUV6c5m0mRMMqPUTUCerxGVlXv1ztJHJXXR85h+wTaBZtv+1X
	U/VX50dpkm9UfmwHnH+1rMXgX6ghMKHxY7KFt4nnHUybAXr/AScr5ZMb
X-Gm-Gg: AR+sD128xKaTTNjMNFtzOOaznFhyWmL/HIVd9CiChDBiZpSzLJSFm1OGMvJv7UkKIwp
	zrC1z+rWeuIe3f8zdpgV0BlRdJjbBxrX/f4IDXPcqSBUeqkh5uU0nSXX29g+25KFvjC+UP23Q/O
	Y7Wr6VAzf5yhn2iJyxhQwdocuuoPldaGeaDOlbmkt6aVmseDSwMYNCmd4vNTp4X8/KSXRzuRUzL
	hWH91YRqmZeeAeG95PVAAEFKetdfOdMLaUvau/rHUVjlLcaZV8Y1NarmrFWAnbhdV54/KiEqA0a
	IRUsWyE9vxz+AGZs1mI61Gq1RRliKtd5ptxGS7/M7CVHW5+KZUWmWxWKDC2WvJ6RogQpWD2kkB0
	Hl9mSIHy2IjBh3Q82kiUIdKaoO5zZggJBcwuhBYmR2MbXaOtPMZbzGuv3E/Pz3wKTz8GJ34mm8F
	/GgarhrnEULUPN9c9H7dUXaadFSae0BlkH/7uhW3NjaSuPM31aehu8ZvjezTY=
X-Received: by 2002:a05:6a20:d4b:b0:3c3:a722:59cc with SMTP id adf61e73a8af0-3cb85ea6f6bmr13948363637.22.1785979206355;
        Wed, 05 Aug 2026 18:20:06 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867d4929sm21821361eec.30.2026.08.05.18.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 18:20:05 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: PPC: booke: Use min() in watchdog_next_timeout()
In-Reply-To: <20260804112011.59416-3-thorsten.blum@linux.dev>
Date: Thu, 06 Aug 2026 06:49:29 +0530
Message-ID: <se4skpum.ritesh.list@gmail.com>
References: <20260804112011.59416-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thorsten Blum <thorsten.blum@linux.dev> writes:

> Replace min_t() with the simpler min() macro since the values are
> unsigned and compatible.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good to me. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

