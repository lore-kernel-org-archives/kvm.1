Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C7A3D9688
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583012; cv=none; b=uBAmOto4VoifJ0rtwGGeLP2AuBk64yy2WGqxu343GupUiWmIDWVoY9HntmfyBZ0HQZMOqDOG63kk7uD2/LG7W/+myIw75A5sgdF/R6QraeQexmE3XyUdUl7Vw/nresFB6gfY7judNS46jeUPXRVyH2a3Xw85Ct9uZ6Co+10codE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583012; c=relaxed/simple;
	bh=OoAI2FdjtcDHZAxxbp0Bp0QijICGHh/0pwLxgYcKVEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiVCWKApYsRNGWRHmwUyErMLxiJkxlOE2+7jrrwA7lu/E342poCLffLU3f2tfRI52BdEWO4JUAiuaw1kPFCUXadItBPl7A63PN/SPFCHYmSYlEUBffJtX7JckgYbLC8fcz3flvtMf8aEA9n/iuXPDozdDgGljjtWEnMK4Qz5G30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=szH3f1LY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szH3f1LY"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493d1e8aa46so11737425e9.0
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 00:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783583010; x=1784187810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N7eUSdR0DyIiI153j39Qwy65OXz9wuC4shQvA/Svox8=;
        b=szH3f1LYd2t/A7qANRe+GtsM+kr7cUnRNars8ffzuyeq28ua/5cagZEbrVBPAz4Y8y
         /hBVONNq/mdsRmr8IIXAOtbKEGm0a+KiOjM6wquDxaBtD6mhZSylZDL89vQM36dRDqxS
         1A5Zwm4J2WpgqC4/4j5q4/bYukanhtfRqF1uL0rQc35AA/VATdZ/5HZMviq5vod8PgcG
         sBE2CgDWZ4do/Ffav086jWG4rFSiWIERMpV1wU90rlF9JbEZJSJxgF+fhYZZVcqQvXuA
         IIkrqkd1BQrZ8PakqRHh/yromBMEHbkGd9nkiH+LasH6x0JfQjMw4SFka/uyi5Q59a8l
         sHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783583010; x=1784187810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N7eUSdR0DyIiI153j39Qwy65OXz9wuC4shQvA/Svox8=;
        b=kYX+jmN5H7BaqMy7MrBUT38TN9OO7YDpllo7m6BQi2c9L8N8phWtpbytRrQIcO9djd
         1lwtmh076ex2Pn/pbIm1R/hEtxdbmXkEtL1k7ieKGg2PKc8YyNucVo68gIe46iw2zFGa
         iMaBj0DaZpdDoRxyxNAaCgapKeGK4q4+0xTNloKryuzOEJ5iXKxBZXh6sx32aeF2303t
         smSzYow1Rso5L1rOa2xIrTkJcglv+1r0teST0F7Jl3aZfESL4ypxijz+8up6kv3vEEQ1
         I/64WUbrTMMt8X3B60MWTOaJgh4yI9AIhLCETkFahvKuDz25cvwk1DXC+uvzbC2u6ZcL
         oa2A==
X-Forwarded-Encrypted: i=1; AHgh+RoS19nwIkQ4y94AVt6WH+nivSKyDdjb9iSxKzDr04LG//7YH8IiD5budyyZBG0aBla+/qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpRDy62pvJBVaUVksLJADhiUoY2l77YOH0RRKzY+tCRI+1eKYb
	fGfix7P0fdJdN2jk6CT86vsDPPIAGn/H2eawJyRTV2w+QI3eLEGrHbZGIW5U7XwYlNM=
X-Gm-Gg: AfdE7ckDUcqI8GhwnBhc0paj5G0okWD8U+wF5y5txXZ7FabqfJjKzzfpop5OGmqft7C
	zlYB3WxwkywF49QV2WWEVxZcef4mjwHraXL7M4Zn9U9MuYB3aZpc3NGKZK8tIJF8F4CubGnJcQJ
	d7ptIbuYamAO4wFjFdF1Wfkz7ADBBjsIZKG8nVVhxdbQjL3fzd5I5UHysfvQ57tC1kA7hXNiBO9
	VHE0d0vJoxPdNWlfYjdHXNP1hzpN883bHRkNapSTMKmgzNIvgs7Pzk2EkcHA3WlKuY2TalVvqf/
	baJHuAEOlK4kVu4xu/RupgaswVor+oPi1Jp2jDiFG22k8cUZqelMHTjRAKtDGIcQs9NQofd11C+
	jYRv809X45P1WqDljzenFvJWfOLDh5g10H9QYTLo2URaygQCqCRROPaJ7Z37ismOVvN72UMS7fE
	Yq1y/MEiCJNcAWzfIPiX1tGxCO8FYJMVT+yIhsIpdM8gX9Fc5123T+FTj4oveKyEifzMeePUmzt
	ooRfP5lgcOc18M/+gSE1dA7zpqI6nWZyZj69XtxC2mGzTa5kRxCwa0VLjs8sZKrCjr5qoQ42MSN
	T3NbZRY0xGJdd4D1HxEHmQIfSdOr
X-Received: by 2002:a05:600c:83c6:b0:493:c42e:5be0 with SMTP id 5b1f17b1804b1-493e6853dbfmr61124025e9.0.1783583009667;
        Thu, 09 Jul 2026 00:43:29 -0700 (PDT)
Received: from z16 ([2400:adc5:134:ba00:f774:65ea:79e2:617b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ff6casm50109985e9.5.2026.07.09.00.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 00:43:29 -0700 (PDT)
From: Salman Farooq <salman.farooq3310@gmail.com>
To: amachhiw@linux.ibm.com
Cc: chleroy@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	salman.farooq3310@gmail.com
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Fix comment typos
Date: Thu,  9 Jul 2026 12:43:23 +0500
Message-ID: <20260709074323.77322-1-salman.farooq3310@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709125357.49cafeb6-1b-amachhiw@linux.ibm.com>
References: <20260709125357.49cafeb6-1b-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> Regardless, since this patch has no functional or code change, you may
> want to add a 'trivial' suffix to the patch title, e.g.:
>
>   KVM: PPC: Book3S HV: trivial: Fix comment typos

Thanks for pointing that out, and for the very useful references.
I wasn't aware of this convention. I will follow it and read up on
other conventions for future patches.

Salman
