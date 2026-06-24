Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E6C3AC0FB
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293157; cv=none; b=nY7G1Icj7fGUmO1ATAzUKDz6eh0uzZ5h6QQKw9ZgDbJAtKe+dS3T/YjzY8l3tazhu5YrOKBHQ1ByRSMW21juify/pIHsunEbEsDmW6VyaYJtd6ExTdAkpHiXW3NsJfPBkCA/lc0x5SrvsUZfhh+KhbcfVcr1xUs/dSd3CY5ZmX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293157; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=if4zhaPOltKN/N4rvIznJTCq289iyci7nLzkitQAff+qUNo0s1ZauqVlh5TeX8ItcTaWeiTcTFNs9mU9bFusvuhG3IX1hAg7Q8JHZatTqAaSdq81ahAa2GjRX/2lJIeJRb/2xj0oawP9mpmYVwIG/+jETkbpRfc+P+jp5eZHiNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ChM8L8q4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxUehXgO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ChM8L8q4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxUehXgO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782293144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=ChM8L8q4CPNBc6ktL+Yj3h7G1bN8PkaJ4RdZutrzst4hS6STKsT8eXGoErn65V8uBbyVSH
	H/N0sG/5DzjjTGiXJDBc88n6xevBh19oNXRWag9tpBIt25/t/DwSTLoRFKNwpIXAfAt2Nx
	8st7QSnEzQAeTSweG+xtGlW06UIQoP8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-o054lt7IPkOGfxPS_qNG3w-1; Wed, 24 Jun 2026 05:25:42 -0400
X-MC-Unique: o054lt7IPkOGfxPS_qNG3w-1
X-Mimecast-MFC-AGG-ID: o054lt7IPkOGfxPS_qNG3w_1782293141
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490b37e1f47so5610475e9.0
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 02:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782293141; x=1782897941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=bxUehXgOplA/zOATm6qhoKD32MowGos76mkGLMbZTZSYI+9R9M37WmMwznbGd+3Lro
         Ne2aErh5qkqRiaVbB3GLFuO/hLyR+7CHa5fAE/GLRXtek31xWxBVSAEaMulljz4mcRHq
         PPM1oiOLI0yvgGyNMwm1x+TZVWfEDQXpKlJTIl6Ogd/xFghkWcRlNTiYE0qexo9vfapI
         W2XhitNiO6/woiFSe6/co0IAzBw1CxigVEZzWTQwaiISSgVxl3rKsdlGYUSHtrsCSO4U
         i5lb62KBxYBqmZX+3VufFTlhuDHqWUbjRjGRGeIF/ySUKTflLHKrHwCviCcLjVNXSOhG
         cxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782293141; x=1782897941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=poGTWe0KQG8Qz80x/ce8SP+RtI3PGf5sKNnh8+Ji//fbL/Zht+3GY5i08ZSHSafDC3
         MQbXW5kCYwTxshwBMVPDe4bZOOYPbsK19a2hjRDGyQtmksMP9pc6TQnXcbOJ2aMmPipe
         GnCDFfCrWzSXLbiuG3haAlpqWB+agEun8veI5vfC9xEx8yXDuneDd99PLATngKWPG7lP
         tK66rnMkLO92vSScVF7lJu6DxBptCROxM73/sGLzL73rwcU8EUutEKM3M0u8CKejoLMK
         2C/bUApyvMeo1mvxksXETFC2W0Rurn/vpSnMtgV/z6RN/KuPZQXx5fKuTw7m4UYKn0Xd
         alJA==
X-Gm-Message-State: AOJu0YyzLIQG14cw3jZA94s5hlUuMbW0X/2KBx0H4GjySVD1LJGiqFym
	QB6W0PLjDHCj4nO7sw6/P8/gIHr2NSJQQ/334JlKgIuL/dbHZJky5Qh5YnPiLWQrIbqOraLll1K
	hMeAuJuAIWbQO39UM8O6byggt4VjghxaJrCDLiDbbyzU/PmyY9YqOX6mrMp8a9g==
X-Gm-Gg: AfdE7cmcHUgQXVz/znouLlsfN4BK8y47Xv/nYcnQplwDDn9qdgmLUoJol3qQ0SuEtIS
	VyNL+qaV+Rb0eDurxUa8aPtE9Ykmh4MZWgkftv6PzWTU+1ID9iqDrNkNVMv/ecibHq913znYM5V
	nEUwjQdNvSuxTUjnPFS13sfbxVIPXUAiPDhQeQijh2fNFUghQC20bwGYCjftFZQ6ZP9YGR0OikW
	ZK9Anmze6+HI4tt5E+fY+9mkfxl/TLdyWPUDE9O8wGZCQDtRsSt6pvDMs+M+cTKuV8HzuQknq38
	hdO3GGR32Zycme1DKjWsDBveUA8rZCijSmqfonRLTSb0t4UFhwNrfdaGygAQzcpUC42CEEyCyom
	nEepiE5iVrV3Lin8BCE9vNTjTp8T/aE0omYJMj0itIwghz8YIlaIXuiEaKCdnkKUkIPZghjJEMe
	uBi7BK6lrgcfwnu0Ae
X-Received: by 2002:a05:600c:1d16:b0:492:5855:1548 with SMTP id 5b1f17b1804b1-4926087830amr31961415e9.27.1782293140838;
        Wed, 24 Jun 2026 02:25:40 -0700 (PDT)
X-Received: by 2002:a05:600c:1d16:b0:492:5855:1548 with SMTP id 5b1f17b1804b1-4926087830amr31961075e9.27.1782293140438;
        Wed, 24 Jun 2026 02:25:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249207dabsm653676515e9.0.2026.06.24.02.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:25:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Replace BUG_ON() with WARN_ON_ONCE() on "bad" nested GPA translation
Date: Wed, 24 Jun 2026 11:25:35 +0200
Message-ID: <20260624092535.971604-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618185746.2023283-1-seanjc@google.com>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued, thanks.

Paolo

