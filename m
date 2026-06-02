Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CAF37F72E
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780438733; cv=none; b=Fr4qMJ/UC1D4awDvNzwWnPV0LWA/l4g7JKXYu4mhuajxpXARSxuJ87fEVC7jnrCq9u8y7qJSPHa8XPN1C5k35MwOtbcg28Cs9aOqeAHvSbs5H8hYWcJmqYeSIrs/i5+qFQZl2yCFrxfi3YPP4ktLgkDxlpIKF3VwDTFGExjNASk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780438733; c=relaxed/simple;
	bh=mOj/mm+e8bp2/YJzCq6+9P0uMrb6LHZnBSavOSIt+Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plGUN7gp6cXXPtEnh6X54C2j7QLNaT6WuiQdSyFajetyu7pyp+Rud9k4HDkFeqcZCr+7b8/YT/jFx6RNOUVG/jh+5NbN4zAem84nseHgZpHXsLe3Z+Rs+OxIYRzZ/5q266+o3w5gu1/DOwgL87u0VkocGriedvleIKf4dPcaZOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bU2FwIqt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bU2FwIqt"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso29766265e9.3
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 15:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780438731; x=1781043531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cw0K4qIf6+fPTBj4/hLwQ9yPr+Jm8wfwQ5XwEakJxQ=;
        b=bU2FwIqtI/ek7x6UMBn11WtrKx8FlTReBKhq5plCr1m3k/uobjxpoIlp7zMVMnTZBl
         3thz7aX1ott5Fs5kVnV4SS4bd17PzNtd1MsTx055upcCO443IjiC7yXfbhxK82jAhcHY
         3hAEDtli9C6Q/a+KOLuMuO0umM6ipNHKRDFLfxNUXfwlilC5eP6K6Tnyj5OvOMkj8fhX
         igu9ETyJIFH8+xggG7gD2NH/MaTM0oznAvY8qJ6fh9iN/5427lHgQLPmMkOCj0o2PUgA
         fC5Fg0mroCEwMR7zswX28q7RX2Ihu546eA03jRF4Z22hYRGjxu131dcXzN01P2SwicDD
         hSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780438731; x=1781043531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3cw0K4qIf6+fPTBj4/hLwQ9yPr+Jm8wfwQ5XwEakJxQ=;
        b=mkhR66rhiUN7ll6yOPmhuTZjyyIVBVevp5OM6RMXJJcsCgcZY7wQ2QR7L1x6ebqjbz
         paor/ZjGovm4hblBc9ridVVANOBSD9BxY1o33lGF/suXzQpoeFklfHElFI3bsYchza1O
         w2qowCzPREAkycMh3cTiRYpVZplIHQdHTw+QkQAxNJtf+B77JYB97hyMfA31VIPBUK6o
         xPPCAdpwph5a5QS5rXQE/UXBHLHpvndyT+ekgBtr08ChPA/YETxBZvwYCvew9Rp0bKZ7
         o9yjuTC8SkteqyN/L5aQjgpHiEm77J1kRkx4eXc7FdOjLLnFmiRYxThey2nTpSaH9AZj
         SU2g==
X-Forwarded-Encrypted: i=1; AFNElJ+FOgjwLxnUvzMS9mVvtCPu+hvvBNZThAMdrUQyU2d6qLMJM/6Fdtt1GtfnfoeTdKz0Blo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB5jcpLZ4Xk/teuKs5FxRjVwoqG4QigJyfg5dMiRURV9d/DJlh
	hykWrQrFX2h8t5/xznmR1mT8XrgYnf8YnhETir8zXYXqfwS1RMQQHiWe
X-Gm-Gg: Acq92OHpOIUdx4qQlsuUScmCQtuDUcEkgvcY2hno0c6iOGb8GVUsgVUObODyR/pdvAv
	WCNFb6grPlBAX53SUL6Q8H/LW9YEXRQ9u84DLHTsT6PTsl2W3hmjG2xa93kMtbZ3tZr1wc4EnQ3
	k3m5ASU+7DhTrcumvOTpS8tgf+iOFkBpjhCHOtgVPRSFpwyn+BXMQDQzT72UlYL7PwqUC5ffGy7
	Ppq+w+I09abpMusuE/p64wt+aKfxQnaEUoRLLfw6Muvo2Q5z4gC0XUeW9cChFZ4uTdUWXVuRcu6
	ns3t95dMtGSICh1HEgnjTbhRenotKyXyXXLv1NfXRD2qjBcmmFpdscE2nJpVPmiWqZsUe5vjea/
	m+eZbNWSf/KUG5NJHcldkosNnUOJi4nsvGRbLc33QF45rFGl4tblMkLHOykaaO+MfsqlKxA3SN0
	WbKkTwYrNR5oB+k0s9LiYdHLA1qu0/35BEj2JEPx+8
X-Received: by 2002:a05:600c:4fc8:b0:490:5057:f5f7 with SMTP id 5b1f17b1804b1-490b5e8cd0cmr10087195e9.11.1780438730762;
        Tue, 02 Jun 2026 15:18:50 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f2dcae2sm2882120f8f.6.2026.06.02.15.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 15:18:50 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: kas@kernel.org
Cc: Liam.Howlett@oracle.com,
	aarcange@redhat.com,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	david@kernel.org,
	jthoughton@google.com,
	kernel-team@meta.com,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	pbonzini@redhat.com,
	peterx@redhat.com,
	rppt@kernel.org,
	seanjc@google.com,
	sj@kernel.org,
	skhan@linuxfoundation.org,
	surenb@google.com,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	ziy@nvidia.com
Subject: Re: [PATCH v6 14/15] selftests/mm: add userfaultfd RWP tests
Date: Wed,  3 Jun 2026 01:18:31 +0300
Message-ID: <20260602221831.77366-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529172716.357179-15-kas@kernel.org>
References: <20260529172716.357179-15-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Kiryl Shutsemau (Meta)" <kas@kernel.org>:
> +/*
> + * Test that GUP resolves through protnone PTEs (async mode).
> + * vmsplice() into a pipe pins user pages via get_user_pages_fast() --
> + * unlike write(), which goes through copy_from_user() and ordinary
> + * hardware page faults -- so it exercises gup_can_follow_protnone() on
> + * the RW-protected PTE. In async mode the kernel auto-restores
> + * permissions and GUP returns the page.
> + */

Note that I recently submitted a patch, which makes vmsplice equivalent to
preadv2/pwritev2, and it was accepted to next.

For now it is just an experiment, it is possible it will be reverted.

https://lore.kernel.org/all/20260601-aufweichen-dissens-ausrechnen-0d9b84728113@brauner/

-- 
Askar Safin
