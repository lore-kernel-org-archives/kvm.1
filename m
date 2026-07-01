Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939A0431E51
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935395; cv=none; b=a/IVDzTFmVa8QF1w3r9U/ckxJHV6vfiByvPMN6G9Ge++ypGKTER+KBaGqdDHPE7+cljozQ+mftznBCLeTsw173ZhRFKQp26TRrriExXp0HwDvSNsNoelfFvclL/2rIPgjJxt5rqDDHE2zhyttdXLx0qzkGeKraVSZY8mET/uV+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935395; c=relaxed/simple;
	bh=hYnYH/a7NeAfySEmNN7KJOJTRxT09G2j3yaIV2Kkogo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mImyUVvpG9EtfGgkZLcMmbHT4Wy3k0lL7Or0WxxobI78p+WTCltfQ37K1qme9h53pW6cJlquZHeGrutb47Gb1ZNVGQ0/Hff5yp4p1GiqFtOpJDlvj+4w/0Ec+ONK0AG0ZqvQSYfWUa6ZclzS3Mw7E4dLS1t2afnRrq0PeCBCNXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFIE8YWO; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFIE8YWO"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso375382a12.3
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 12:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782935394; x=1783540194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6XoBYbDRjK/6UvFvju36vVUh0rAa1wM8WP+aHaR8ZBc=;
        b=hFIE8YWO0ldY+GkjeFkfrPnHPekszfwzzdGLIASj8dZaSYXf61512Jbpcpo5l4n+xp
         T79qTzFyWeqHFG+Xi9YA5XPqDYFJxKqR+PfqLXptNncCarw4AHypUWxQWsSFG8rb0eaK
         qsQZrUOnEYykmU2CSS90hAReM7Uf3j2Ckp5SwdQV1SiJIKKmMKYoN3HsYQYsDT3ZFhEc
         pLxobA5LmuPQ+SuuoQdxmZOv4u1o/pR0e5nPRuJIPZIf7ty6cxyO10qqALq11TmhnmuX
         K0dJtn8FtWKo9PydDSmdHcZLbWN+iIDzRChEpBxPSl0+Y+XsDlYzg+LB6U7DAIjCLXzY
         j5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782935394; x=1783540194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XoBYbDRjK/6UvFvju36vVUh0rAa1wM8WP+aHaR8ZBc=;
        b=C7NUsSWRc6vDukzW13/zLMdV1zfA8a/MiaMjtgEmwxrKAW6sJbUaL5socV3ovrGOnd
         5mlB2FWHDfwuN4Mal285H8MloVvRjH89ogHkxZoL4lci9AsppPRYY4d8Ux8BeHPKLwcj
         BBTKvRepVp8lb3lh6QFxd8Meb7SMPJGL1ZR6s/YGlxetJS/6JDAxpPmAjLonKWcMZF5r
         r4HSbSw8bDt+TN4u41xT8JVpte92o8N8U5krf9Pvkq494kxQUP8L//rD34zW3Th8Sbe4
         ai+msUvwS0NpL1yuyndhUzdKqe7oZo+e+abqtLamAI9SIWtbCoCTgdzGdf4A/TcmRZC7
         NNFA==
X-Gm-Message-State: AOJu0YybuMn8PoPRRYYMagIb/1ZD6GnOSB3IwRSyn030aEQ05VUZkyNG
	z7jWQOWoJ/unkWY2rvEOWP7ogv+p/E9we0KGYuDUaH2ODxmIjqCKEKXviVjZWVox+t4=
X-Gm-Gg: AfdE7cl8Mi+VGhc1AINMspJ/Q1BQn4bXz9wNG7rMkW9lUdotGQi0kTdF5Ge/5xoRzOL
	Ot17+0vwBN1FvzmzRNqNnIBgXQDEE7RDUOjLmn47NxHz5GclIBEkNzIFcf6ESUFmbAQgqzH9NDD
	olq4Oh4UFS9PUEL2DboEY2Dkv+OfuZHGorZzKYbNmmERx4Ug8Vduw0RXg9mYhn2oweZw02RJh02
	L8MtuSz3CLkF6OLctgZ7TaNmr2l31oUvP8O0iByn+3DwxIN4ax+H4FufgkbRa9HqwkEpSdSZYTr
	1udPsWj9ljZug06/2p/Rv5JfTTMyKO382J3Ft4UbkoIN0T7A2OOYmyNwSVM2jBeVtkaD2fkxf6Y
	/RK7DtgWpczK60o4nvVfg+iKKZ/HZ5BPMyJqfhNvr6UMGyniifHbeDbdDdeR1sGo3KH1NMEg5/A
	+Ct4Td0jRNgBAGiuccCS/LPxv39PVLrJA=
X-Received: by 2002:a05:6a21:a97:b0:3b4:8717:1c21 with SMTP id adf61e73a8af0-3bfed3e930amr3515904637.35.1782935393814;
        Wed, 01 Jul 2026 12:49:53 -0700 (PDT)
Received: from RodriguezRyzen.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b81f3dbsm844143eec.11.2026.07.01.12.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 12:49:52 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kselftest@lists.kernel.org,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH 0/1] kvm: reject unknown flags in device and dirty-log ioctls
Date: Wed,  1 Jul 2026 16:49:45 -0300
Message-ID: <20260701194946.768731-1-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Three generic KVM paths silently ignored flag bits that uapi or
Documentation/virt/kvm/api.rst treat as reserved or zero-only:

- KVM_CREATE_DEVICE (only KVM_CREATE_DEVICE_TEST is defined)
- KVM_{SET,GET,HAS}_DEVICE_ATTR (kvm_device_attr.flags)
- KVM_ENABLE_CAP for KVM_CAP_DIRTY_LOG_RING{,_ACQ_REL} (cap->flags)

Reject with -EINVAL, matching dma-heap and other strict KVM ioctls.
Adds ioctl_flag_validation_test to tools/testing/selftests/kvm.

Tested: ioctl_flag_validation_test fails on the host kernel without
this patch (KVM_CREATE_DEVICE accepts flags=0x2); requires reloading
the patched kvm module to pass.

Iván Ezequiel Rodriguez (1):
  kvm: reject unknown flags in device and dirty-log ioctls

 tools/testing/selftests/kvm/Makefile.kvm           |   1 +
 .../selftests/kvm/ioctl_flag_validation_test.c     | 104 +++++++++++++++++++++
 virt/kvm/kvm_main.c                                |   9 ++
 3 files changed, 114 insertions(+)

-- 
2.43.0
