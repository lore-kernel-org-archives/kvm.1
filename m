Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDE533D512
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 04:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785472935; cv=none; b=CEtGYExnIrRn94g8WogfoN5fzfIc4+1jjeLNDH1+iZdTet/2aJy9T5/yqab0zOaKdZpk677Vs33J6oMadqB+sDLPeZc8rfQ5rBnIkFLyLVAWJozTlPXB+AHm52HXKTkPz6CvD/oqDLsmHu4nZEmD7Lznl6ydzVrfSxdgZNgk+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785472935; c=relaxed/simple;
	bh=ZMvyUCyEVG3QAjdzCqMKBgh7MXLqXhHhJWMaYN5xfHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oQAqvbvs9+GpmLDgXa0N9Z3Zj2wPmVyasbRrpZYBoKg+K8komGKdbLjn9nGgWwDlaVRYCIC7/9epGRjzkx7D6gYHdlX109he5p92A+1RAdHHZsHIsLX7FKNne+SNkQZuiP5QwWMvNVTXTxNTrIffH03YW/ajBy8cpjOFiIiq89E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftGY2Zkq; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftGY2Zkq"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ce98cb8165so4337765ad.1
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 21:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785472934; x=1786077734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UBxrxqOA4cNRIKhpkuQrq3xtaL8oWVG4/TQjb10K0NA=;
        b=ftGY2ZkqIkWsezngXcYhdKiI3gUJdkepw3zIrRZw6yniQCExtyZZNfFTCwIRbV/CaJ
         cq1yKX2KxnnlabdoEbJfQMamnxJTXidlXTTtw7sjYouec70FUvbCOIeT+a2qap0+KP/u
         EhLPN7tNKEl9oEbFa1rfRoeRw9kNQbz1r4CITrFJLRP5fqeMyQbz99KytMqtD9fTox8R
         AbNCxcsb0zPoLg4BU+rMcPrJac59kjuTcFHnniS4QdwtPCBWBSwLCxSxvBigWERkda+F
         RMCn3SQiTrsDdPsgyyuUuTFx5/c2ubXdal122rWKDIQOJsTF5JmevyGEhbBR+AmXcZPc
         B8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785472934; x=1786077734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UBxrxqOA4cNRIKhpkuQrq3xtaL8oWVG4/TQjb10K0NA=;
        b=rZNWXW2YVJtVew+o04/lStSWk9xyPTfFWfGdIrQcDfgbUyGRCywU7p1dWbrdxg44+P
         nyIZ7ZrRG0MmvwcJ+U1UjV5Fh0T0qMq5aR7Hy03xZf5CQ2ETk4Ro1zD//7sJ9msOsCca
         HYknZFiNtb9RfvSgt84zACErCfrMIZgkhKzZVOdiWrrY+VbcLAHkoExqVG9GH/K66QLt
         LdOIPJWvuR8B73eCEzaqU1bsV/+/t2XxHOnr6At9MaIZJEzgdbC+oEnoLRSasH7ocB7+
         /1T2/V8JyMZ5Ygw2fJAz5A9rkun9GCfC8ysCZpaCEFOq7+8pi9p/I/qceJzXNH16cMXz
         3xUg==
X-Forwarded-Encrypted: i=1; AHgh+RpzACbzPA6wFM+kbe+M/nPhYLG8qAOU8QekoCWVHhz4f1BUXOcWbma7L7aAxTBOys7nbhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgXAhHitndMeSJ3Ju53GMwFoe8J3T+P9uVcYbgtM+ixin/UB9P
	A2iv2ABd2keMl+4GXokerhtXIhBM2idzhbRFnOIaVbJ5LCSuhQkFf4R+
X-Gm-Gg: AR+sD11Dhq7OqdENnWGHGFohqwsgWFRDUIAdgZL9ECjuHC7+8ndQgdqJ5wrcLs6eG7u
	G5wO0aryHM/HbZx7NOc4s0XiHf8d7a4KZkekf8rJYWpiw+5M/rUq44CIjf/dtlDnVYlg0JvAtwH
	GU30bvi2QkGuJtFs121VNG47+pA8wCh5x7ISQ384TkAQEDF1VzQGlLLB/u8N879Vulk8LqgeEiD
	9zbTMIF+gizT57rsVq9nYg6vRPeL2KiRVGOKFm4DVNdnlLlStAuTE5Yzxmzro1KCDIVuQAMvMik
	HyOx7LuSQGTmQTlSimv1nZfAGHytjOp80izLbLdVc8342/6XwPwFmJwWMbzoaUUnfdVYodETpdN
	JrD7IUOLRkusq555NQsFDeZnpg2VpV+APWiH/Bk1YKadzXJKFfR2Ur/+1TGjNIOAq+3pYAD2tG1
	IH/LWRSN7niP245d1EEhLqGpU0UDI0Yp1U7xWuChos3Swnc023WnRjEK2xNk2ni88=
X-Received: by 2002:a17:902:ceca:b0:2cc:ac15:ff4c with SMTP id d9443c01a7336-2d047d5481cmr4191885ad.8.1785472933339;
        Thu, 30 Jul 2026 21:42:13 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c93dsm765243eec.8.2026.07.30.21.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 21:42:12 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: stefanha@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] vhost/vsock: prevent stale IOTLB after ACCESS_PLATFORM changes
Date: Fri, 31 Jul 2026 12:41:45 +0800
Message-Id: <20260731044145.1734317-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730104857-mutt-send-email-mst@kernel.org>
References: <20260730104857-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 30, 2026 at 10:51:15AM -0400, Michael S. Tsirkin wrote:
> I don't know if this will break anything. Why not just blow
> out the iotlb? kernel will rebuild it if it needs it afterwards
> for some reason.
>
> This part you are fixing is harmless. Let's make it a separate patch
> and document the motivation.

Thanks.

Yes, I considered discarding the IOTLB before choosing -EBUSY. My
hesitation was not about whether it could eventually be rebuilt, but
that doing so would no longer be only a control-plane validation
change. It would modify translation state directly used by running
virtqueues.

The minimum synchronization I had in mind was roughly:

  vhost_vsock_set_features(features):
      mutex_lock(dev.mutex)

      if (!(features & ACCESS_PLATFORM) && dev.iotlb):
          lock all vq.mutex in index order

          old = dev.iotlb
          dev.iotlb = NULL

          for each vq:
              vq.iotlb = NULL
              reset vq.meta_iotlb
              vq.acked_features = features

          unlock all vq.mutex
          vhost_iotlb_free(old)

      ...

      mutex_unlock(dev.mutex)

The switch has to be serialized against all active VQs. My hesitation
was that this turns VHOST_SET_FEATURES into a datapath synchronization
point: the ioctl may wait for in-flight kick handlers, and rebuilding
an empty IOTLB may stall queues on misses until the translations are
restored. If stopping or flushing the device is also required, the
disruption is larger than a normal feature update.

I was not sure whether VHOST_SET_FEATURES is expected to impose that
cost on a running device, or whether userspace should quiesce it first.
That is why I chose -EBUSY for v1. If synchronization with active VQs is
the intended behavior here, I can rework the patch accordingly.

I will also split the existing-IOTLB preservation change into a
separate patch and document its motivation.
