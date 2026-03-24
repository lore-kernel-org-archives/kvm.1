Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFEE3AA4F7
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 06:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332942; cv=none; b=EGjXMN8YSX8zUZd35nxyohj0reqSbk9AkhAJfnT+R9PnRh96mPTuECN2+T7O7qKtNcYcXIQGQzp89CYBzHFWrEBrJv95EdSk6t3RGvEZPcsDiBonjdQpdnC356upHzIfuyixB8rkm0bM+5IdmQSSqtsOth4PH9Pem1ee3L8x0ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332942; c=relaxed/simple;
	bh=yu3nC6vhpzZez3hZu5WSDBz9l+V7URi8BT2ABBFXuP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGO34SKRTkZRam7/qXqJV/mfBWCfG7lY7EmPKlZDUpHm5VmgyucZr8O193WMBxX/u4MUhZINyBdQerVwA9vl8G4UvFTNXqPTA+4jsAOJiI4ktGZRP5t6nEnME4kwJe+LuNDG79cpSqMU5tG5AvKriBr9OwdyfZVKYkwh+zJG7NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKYgr/Mz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKYgr/Mz"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-487035181a7so18794285e9.2
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 23:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774332939; x=1774937739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mifv6lV/1vhl2tnAgC+pUhj48DLTv7wevR0+F6OEtI0=;
        b=DKYgr/MzsqhaJNVAVJS4cG1jw/uMJhzMwOUA9Ww7W+9y/lplLAW+v3xVYiPpi2iw1n
         wFycdoOVjTYGZo4+7pRrFIdkUNfvMgi98HbqOoNk96n4MKsdtZW/leHJWxbWRb0yA6P/
         QgA2jS00cSJip6Lv6AlKdRjlSPKttK8ogy7r13O3pAblU5gfu0+AMCvbLeFB9rSkDdCI
         Ujjj6RMxsUnORpIqgzt52DK4NIOqJYOFyvdRRfGe9FIX+dHM7IEs3w6I0xXP/zf+Jysj
         EJZGqti/6LEUZ4tHeb2YkmovL/sypU4LK4ZVMPkN6vnAMPxntIMOAkvHHIAq+vnmsBXg
         p5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774332939; x=1774937739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mifv6lV/1vhl2tnAgC+pUhj48DLTv7wevR0+F6OEtI0=;
        b=tEH7Uq4+bYfJ7wiJgq2eQawj9kff7lpSxz+Dz3YXsoe3pD3VbXKAFCvxW4GNbjjRi0
         uMXvdMk8ig6ZGcdvvNOkSB2YJSWTE2l1gGrNnAYs5W2mfdIgo8oyJ/k0h/2K1fnJkrM6
         DA43+2DFVUcosvQ8oPe5MdG9BQq8F3TXjb4OigRPDVocoEndGRuM3rgb6KjWCT0/T596
         LXavvQ61ecPckmAN0D1lHmXX4ssaCPCEufcExgbcR6fv+4FOS10a7v+5PfzZ3+yGI6X8
         i0LYeVzEuevPkwdIMf0Vk4rBVu0qJePvLbnaEUf+wn6+Xr3826y5pzLjAZw5pQMzxpKB
         m0hQ==
X-Gm-Message-State: AOJu0YyBqFPuNDUPCoHQMr1FgtbwycLFfy8TBT2eHVHQ8jGT7GcMvhvH
	/tLtbt+vVfsJxDYqUBjzdZLQneWBW8IW8GvjuV/rciXz5ch1QGtMxVRj
X-Gm-Gg: ATEYQzyjrq/v6nSFotgB2DpZiz8yvMSeM3Mhxp37kXRfKStnv2BWZujFeteTnUz5Ln9
	RG37y4bcSm3PlXjWIB7vH4L37+D0A/w+/NrA6DvrgE6grpZA/6A01YbhAO5ulcsVlRgdCk8pxU3
	jUuJN8bikw5lbCDmWgXnqG+MJzu5b8Q6xnpaaNNx6OezHc+aI2qgV5BRcBbXVBATRypigRte9VF
	cYyQTvqSJvW6ud5RttQsXRJJKVc1KwkfNmUGxRUVZ/U0QkQxjQ99Wm13D7a960yASeDay2uuH82
	UzBqk8WPSznV2NnRejuWU+Qn+MOsWrRKTshC/ATqz3VxPFnh8ZAw0GQZCS5PwgVp3xWm8na7OkK
	lw7q0xwFJH496GidZezLpKrcdpHujgx2RvfLdqJNJ4qtbdpxxMXrwta4aJGX+cWL1kg2rxGvC0/
	gZQZaT3QdP6E7/tHSxoyo=
X-Received: by 2002:a05:600c:8b25:b0:480:6bef:63a0 with SMTP id 5b1f17b1804b1-486fee0d8cdmr212926635e9.21.1774332938609;
        Mon, 23 Mar 2026 23:15:38 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48710fe6f86sm13091615e9.6.2026.03.23.23.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 23:15:36 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: babu.moger@amd.com
Cc: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA) support to the resctrl subsystem
Date: Tue, 24 Mar 2026 09:15:31 +0300
Message-ID: <20260324061531.3221932-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773347820.git.babu.moger@amd.com>
References: <cover.1773347820.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please, remove me from CC list in future versions of this patchset

-- 
Askar Safin
