Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55FD33A6E2
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785822415; cv=none; b=M6lbCttP+YYNQesa8x7ADUSCFIRY3tiB35uUeZevymDS3zq42TnYAuyZkxaaXC1tXdLvFvI26/bJzaS5iS8e9RwRN29Y/1TgWGj3uDnN6Z1N/o0Yrp6RLGO2622U0lN7cnnLdoceHWjEz/fxl9XSUxxlmuoGAQlzqI3sD0d4UTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785822415; c=relaxed/simple;
	bh=Edg+9r5X6Hx937Ug59wtr9oIszVOyJNcrBmngu/d/Wo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lvi1HK0F8AphiF3g8o+z2CTLvBSM+lpKwNUU8Y9LFfTvCgRRIg/yesouxgPrADoTb5TIuL1dJIA6pB/gf+QELXTRa5JlzwPIMAg54wnv7PqUiXNTnieiAuE19H1TfwPVQRlboFIjCYQ2HcuZBpmQaTXkp6voWLd7qqWktsL47ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qt1Dcl15; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qt1Dcl15"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf50c6f235so47128045ad.0
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 22:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785822413; x=1786427213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Edg+9r5X6Hx937Ug59wtr9oIszVOyJNcrBmngu/d/Wo=;
        b=qt1Dcl15Y6rTRJAmEoWT6rSKhsSA92hYmTT8zGBe9xiukuckWGhCW5U6iDpiUBKhfq
         jIHTWtPza4U6KJMm3eS8SfU3gyRvz/Yz14qansjAuZP4SS2QPYt72bJY0UbPHFhcURCA
         m53Qdv3N2yl1adlrJBxqXwAIXe6yUgt1th/Mdb/d99pXVnqlXUD/TKhtf2rMXySJ0R8k
         yt0RSOyePf2SMKVPOdyd+KjM1iGtis27IXdSNLkafLJyrtaNS8zS5FrKUJxUhOpOI+Qj
         9uUF+WZYfdH/+oeUvwfzgmRMCWzMvVrDlzV6AziUGXABUUdOUDrMmTj0lrKnoD2cCAOC
         TBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785822413; x=1786427213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Edg+9r5X6Hx937Ug59wtr9oIszVOyJNcrBmngu/d/Wo=;
        b=ByObZWXjb4nOhxcc0yB24O6PrfwiPkIzOiQHKQ8IVOzC5C5Qljg30jl3gqcteEGbFJ
         JT98LqLtAq6+K9wjXfLbKrkVlG/Rw3vCfKWYRiJV9M9swLrhQJzKLHySdb+9zE8Ma3BH
         5+/EmTEPV6fYV01Ze5huwkjm7jPKz1erSEFMEExtO2D/4EslErBfgcEPpt7/fuBH7hcV
         CbV2+5kqFkgnayTfK1TbdNenH3Jr/pLBbN+vi5F3IU71aVf12rWkjgROVF/UHG1MEie3
         v5Z6W/DkUzy9XDyzRB9dW0kdvL05Y0fdIyiMti07aVF78fjee/L7XaxU73MD+/gDyMFX
         odTw==
X-Forwarded-Encrypted: i=1; AHgh+RoBrZXE3FIpHuhtB45B5FI2YJIQQI+I3q8CgpKO2qKcHoO+1bwIA67YA5VqMKjL+uZW3kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbYC1aA0Ea+4WfwatKsnN5YeyvXpTG1YPoXnWMlKAo79ORVOpB
	J/hZvzlgKV9cj0xgG19o7+DL8F9mCxHnsUBluoLPXKbVhWn8LWoJTWsc
X-Gm-Gg: AR+sD13UsPZypfACS22ds2g7VYSdWk/nIlCN9NkG3iXYhhQpl6MJ977kz9V43JtfUmA
	dhZ4qUPMvgZ/PndLt+XV4roDlNiZQFxqRe/e9OvREtBvoxJB8BZ1eiGbjmwwlIbVeL/hmY7+mcY
	GI5DlWGvnczCF6oQ8oHT8G35anwdpAIdSPTcMzWOa5/dJfJthFAFSQ7OwgT/dbWpfhVlDwStSK9
	TZdbN5MsEMF/559nmn73T3T47IXTDWWajkqGKyq2KnBzcgBtYMnh10P0oYSVxIATFYLUxtBSVKP
	L3X0FcwLu2UoLCfeGHt7r1NTeCJfaeTXk0ZBgbq/nkBcYQ7JeZvrp/il/YoxC3ivesPxSXxlNZY
	+YeUJ5MVeUm99z8j/QR6n11+3OLxap+pEZGUHB3pSodfc8Dc2JH8DSujv7BOcJ1FjymzDpMtchD
	ratfIWZvvYbl5pP/U6e0GWBlMGi67i/Fkdf6wqZ6MmSIw9LLbS52+wl71Yfh3cJro=
X-Received: by 2002:a17:903:2283:b0:2cf:dc6f:cc42 with SMTP id d9443c01a7336-2d0524b39a0mr116935565ad.46.1785822413062;
        Mon, 03 Aug 2026 22:46:53 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e06f0f9sm45779556eec.23.2026.08.03.22.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:46:52 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: michael.christie@oracle.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] vhost-scsi: flush backend after device ioctls
Date: Tue,  4 Aug 2026 13:46:37 +0800
Message-Id: <20260804054637.6238-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <45a33302-0b28-4d00-8724-c3af6e1783f6@oracle.com>
References: <20260721073639.1532488-1-physicalmtea@gmail.com>
 <3d2dfa19-42f8-4d1f-a411-c72669f4c4bc@oracle.com>
 <20260723105451.1563439-1-physicalmtea@gmail.com>
 <45a33302-0b28-4d00-8724-c3af6e1783f6@oracle.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Okay, I will follow up with the changes.
