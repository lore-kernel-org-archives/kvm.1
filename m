Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE993F8707
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096841; cv=none; b=Olq+DRbWua/0AFaOJjSxTcr6oGgoe5/OvA1h7g69PxlzVXJHdKuGcGiSBBXx+pIZKMOFDHjTe+sRNf+fEAUayWGnJaZ3CK2K3XwWrsC9m97rAolcnRD5rLPmI6KfK4XvKllQ7koNe0LR1zXfsr90wXzIR3uAGvT2iGjzaKFR2fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096841; c=relaxed/simple;
	bh=WE8i65b9LC7lL9iQ5/lEghqFQeb0neL/8MWHHX2SAPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cm7LG1jKJg2n6gKSxwoZ3Q6ICq+jVhjtn1xCkhstDbkbJbHdB7aacCTUCJp/sLGIZbkFnPhIp7h+Iwzv/WE6U4aYldlmcw25+xhOycebQgWOF9xfcyGcPJlXFnYmbuZlQhbupRlNaGTdEoeGPFPGSaelsIjaxgT0WYKXNtxKEpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pm1SLs9V; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm1SLs9V"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cacb8416a1so33294415ad.1
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 03:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786096839; x=1786701639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QQZgcdlI2EieaifCVQjJlrIUWRZzFN6DkbdW2khQ3hg=;
        b=Pm1SLs9Vov4ax6nEhgu4CzxOZs+MSR7P3WXTpdz1PFwe917a57sFkh67hXtDvoqJj7
         UiKLoOulcmT1bPsSkAhNOiNxPId7cRsPSg45sov5/hdJRxKZjLyClutI738g4XSwHSRM
         5Soudi7LnRXtX8zNHhcvU1On4RKmSFFiB9Oc1jLgpCGx6D4D4JxJ7cN8NGnW6w6GJ4cY
         mYpOpIYaAd7Nk1v0eHriKCW5pyfjewYHYunp96L5s8khxO3XCbtaG16xrxlDaSJzu+7q
         DGGNKtuDY2jbPKeSvgK1Po67J3CQmkF2WxirP7NhVC+9KGapmkpb4NUjvg4nLNGpJrgT
         oN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786096839; x=1786701639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QQZgcdlI2EieaifCVQjJlrIUWRZzFN6DkbdW2khQ3hg=;
        b=hQKI7jdk/FEhX0fzJyJfusObsHYCrSbGOCBVU3te5ti36r7I1pliqshUw+7u2PtB2E
         OurmDplyatGcqKlQWuBf8AMhLiGK1Frs9LogHzZhMfVSd+i0Oh/3BQkvnzmsCs3kkT5C
         H020SvR/gYKbNJGphg/Gnv4xkhpxGxMRpnFAEK83lTjBGPrKS5TW7zws2vBkuzcAqKW9
         IaoDMGzDYYfxD5OxTHi3uJQOabBgsux2HAee3XtpQpGpyu55muGH8T6ZMcJA5r8td9tS
         kGAn/fZHb4YIjwba2SAB4UA1dOzx88ZIK/2ipLj7a9KpTqneAVPRVXN4l8VN8qlPoDh5
         lZUw==
X-Forwarded-Encrypted: i=1; AHgh+RqlmOTEuXY0ARbUDQhKuNgEpQllN/VqjXtWxDm2aTqw234M+9wKALj1wfVH3ABI4Afnn/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf5KYiwPd/3kDKmxqTbEWO9MFSx3qsowKjygdv6MYiHkllsMCz
	62c4mrfI3ybQChiPqSuZQOCXWUlgkZmMvkqUpZ7ZvPNieA9rliz6H6qs
X-Gm-Gg: AR+sD11CZCWEQCfC7VAlbEU1/GaKnfqp1d/FcjSJY9LhY4b2Fb4UnwDsAVIiBzGedRF
	n1gtT1LUBLa4i6fMG/qXf6TNBr+JlaAkdM57xBK19kjUkrjZOrAINevDwjC953r8N+0WSbBuWFf
	SlabjZ9Bd34z6geRSjz39qI5NRQbiQQkpUzYUBodSeXw74v9rkQRr6xqLEBj01ifZQum/i+L/IK
	+OcyGprOl4IofyVPF2G7wHzsVmW+JIF3+YD9ajyNDicbPSB07YTwFgBiKe1dozyTl6N/39TE4za
	MNhFzrnXaKxGuJEJ4Ltiy61cZkEXQo5ic2jvGiRIDTVJuac4KWzvaFXnpFsyOvaeuXPIERZ+4pr
	BoytN5LH73QlnyxZ3jxEqyUU1ruEs0uk4wYDm/Iv8Gms1bwj8EUeccGrCWbombfw9MgRTWq97Vy
	81z4IHZFTYSswGivaP/wBYOLaOWliDO/L1vPgpsWqo8pRqwl5CUz7bCX9vjv9XpR/8EVb0RB//j
	N+B/ug/xmdKX6y7cDacVPeRGRkefFX/7Ep7CiJjUmUQrmaKw9AKwEBtXXqMIpcOPR8=
X-Received: by 2002:a17:902:f60c:b0:2cc:aa36:c04c with SMTP id d9443c01a7336-2d0ca7afcabmr254341645ad.1.1786096838646;
        Fri, 07 Aug 2026 03:00:38 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4a9f0fsm6500035ad.68.2026.08.07.03.00.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Aug 2026 03:00:37 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH 0/2] vhost-vdpa: fix a use-after-free on the config eventfd
Date: Fri,  7 Aug 2026 20:00:23 +1000
Message-ID: <20260807100025.19750-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vdpa_config_cb() reads v->config_ctx with no reference and no lock
while VHOST_VDPA_SET_CONFIG_CALL frees the old context, so a config
interrupt delivered at the wrong moment signals freed memory.

Patch 1 stops the fdget error value from ever being installed in
config_ctx.  It is a fix in its own right -- the callback tests only for
NULL and would signal the ERR_PTR -- and it is also what lets patch 2's
lock establish "non-NULL implies valid".

Patch 2 adds the lock that closes the use-after-free.

This is not the reopen refcount underflow fixed by f6bbf0010ba0
("vhost-vdpa: fix use-after-free of v->config_ctx"), and it is a
different bug from the vq call fd one I sent on Aug 6
(https://lore.kernel.org/all/20260806150323.2154-1-yuz08559@gmail.com/),
which is about the parent caching an eventfd_ctx it does not own.  The
three touch different functions.

Tested on v7.2-rc6 with KASAN under qemu, VDUSE as the parent: one thread
swaps the config call fd on the vhost-vdpa fd while another injects
VDUSE_DEV_INJECT_CONFIG_IRQ on the VDUSE fd.  9 of 10 30-second runs hit
the UAF; 0 of 5 with the series applied, with the workload counters
unchanged either way (~30k swaps and ~2.6M injects per run), so the race
is still being exercised rather than merely not reached.  Also clean over
5 runs with PROVE_LOCKING, and vdpa_sim shows no change on the shared
VHOST_VDPA_SET_CONFIG_CALL path (20000 install/unbind cycles plus the
bad-fd path, identical before and after).

For patch 1 specifically: with a working config fd installed, 250 injects
deliver 250 signals; after a VHOST_VDPA_SET_CONFIG_CALL with a bad fd,
delivery stops on an unpatched kernel and continues with the patch.

Yu Zhang (2):
  vhost-vdpa: don't install the eventfd_ctx_fdget() error in config_ctx
  vhost-vdpa: protect config_ctx from being freed under the config
    callback

 drivers/vhost/vdpa.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

-- 
2.43.0

