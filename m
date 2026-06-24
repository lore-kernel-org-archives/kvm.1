Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53AE39C63D
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293591; cv=none; b=O5sxdrnToTNYvb2hw/kdU6goZBUu0ufi0CYx/qCdh2Op4iWwiyhhx3JyUOzYVYeLZdkjEf/2pLSlQ9vJtWaIDA/BAPNAKb0twlWAxqU/Xw6dqZnKXkFGHcLh9aU6c7uLdAQKUrXBoraGMvdO1Nq2uJEWEIJJWLLnxz60yP8xJaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293591; c=relaxed/simple;
	bh=2A1WoQ+R37MzsQ1wODdORjgireYmU9k4MojbPEpX+yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxDtfFulNxRx0dTurAQjk2SrrZJX6eENun/1V0YIo/0BhZdBKUVXfoZvO7LtbLjcFcBAMiQZn39a9lFhmjXDjzwqFnbHt2yAljzeHgURPGwuJpcriTON5MA1W6jcaxwVVjDqWmHkkNQSj/uzxU6m0gzbjO4CTW2ve1raqf/N/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTkRf9Qd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MoZlydKY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTkRf9Qd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoZlydKY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782293582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJ8NWEeA8DD3nZ6BpS2mV2f6+vmNp5Cjiiy/yezAVaI=;
	b=aTkRf9QdmlqivnvT9cI5pZaj9Fvh3MFDLpYN/M4FJ7H2SN+nRpuSHrnSJplZOXmMYxm69v
	9Znyi2fasFq7XVTBLuRcZ3q8W9pI/CwK9yJOdwXu5Nd47x8JpaHK1Lj5yvvmw5p9tYsZuv
	44jc1nuDJ7qtyE3h/dGyw8aSt6h2h7s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-52f4FtdyPrOi2V3fgvAY7w-1; Wed, 24 Jun 2026 05:33:00 -0400
X-MC-Unique: 52f4FtdyPrOi2V3fgvAY7w-1
X-Mimecast-MFC-AGG-ID: 52f4FtdyPrOi2V3fgvAY7w_1782293579
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-46315372c3eso580884f8f.0
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 02:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782293579; x=1782898379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJ8NWEeA8DD3nZ6BpS2mV2f6+vmNp5Cjiiy/yezAVaI=;
        b=MoZlydKYATTYY0oYEjKFBCmItZPbuDjJK4KdV8vEah8O2qeDOId+Bi6VtiIAHChPGq
         Ri4f5hotMbi2ZUYZJ0v9ITMqo4ov0RJaK6KGg+ro8InsxevmBnMwLlmj8Z4SujyEYXey
         vMudHChJRMJujE7mjDAMWf1T9PhG/YijLE8doM83c+UlR3Qf5X5XPMwS/MhgpoB5o+0Q
         yg3pW95nZcbpeSUs51GTgUUOIB+qObCFAxqVKHOQ0qas7lSDx7Nwu7SgouH1E/ZKtQN5
         EhTYq7YJICqBv2VBE5hDmFmVDzanjGI1ouWWszpdBcptPDyMsx7Y2/D5POkaM4oIUYcz
         Do7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782293579; x=1782898379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XJ8NWEeA8DD3nZ6BpS2mV2f6+vmNp5Cjiiy/yezAVaI=;
        b=ObqVBd+lYAHYyTXEgANzHm2r141rTdOeHCiypskwPH7vKKeCLHk7bNAQw7I5a9o/6o
         II3VICR4xv1yoc2q7E/WAzw5oMurfCIXATbDMBGPkJwXUaYgSlExIgIsp6NvyntjbOH+
         AX+OzOoWwZOKJN5wPC9IPtSCFJM6mABoRImlF/tR73Ac6aX2W6mg0yo4aLFLXJBbPo+E
         KtBEStdz099bUeONcQHlGWYSrkHKnBrynNwmibZvGM97Y9jsh5u9rN4meSlDIpfNUmDB
         6pNWM/HRjXKWi3h1BGHX+9bpswjkCzQT+ReyMnrG48Kc0x5rztbHRzyhEnKMyM2T9mMQ
         Tv+Q==
X-Gm-Message-State: AOJu0YylWEKE1+39/ol2BmbrctGTpeNhIXu44aSaHiEqSOTns30KmPvf
	6acsCKaB23SdglFKrsTUDXUSDhjvKyPKjwtwNxcL2WAXvRaM1Q1nOSfk8XTCjIvQTEkdACjLQzK
	EJrNL2Qf3nuX1w/DcbVM2oikCYrWnp1BjXKCfvA+izYHB5EdnN2fqqQ==
X-Gm-Gg: AfdE7ckLFnbVgZU7dM/AbbtHPjzaYfe8JQnfqfDuF0zWz1QcatOHzU6knQ2MFYxzODG
	I9V+c5t2Jc4TknFmDzEuI3ubSwu+co3tFyFaDoxdtZXgUGZLfP5p91n2IwYyboj2/5/dWiZYgOu
	klEuyEmugjZq0Iall/dj3ArjSs+KNuenkqwJwIlniF4UutXqZSdYg5c5vuYIb5DzFaBND9/ojCQ
	o2dxPpjxpjZd5fJAjmikRzDtCnokQXgrQPN20Kl6IL9Yhh9MqmFiV3zxHs0oekg0KIp+ATX157C
	vM45Y8ba/IOLQro1qqd33uhj3E/vl6l9jRPTMkBooe6p/qGpjdEiBaJeYOH5U3JT4a02rYYBdSi
	D5AU7alHLzNw0jAAU5DDg9PQ1kazf1MM/1/OFWzDVmQFjM+tby4rNZg+SmghNpswXgdJqKAVXCf
	KJe16XdHbBva29PF9s
X-Received: by 2002:a05:6000:4b10:b0:43d:7c1b:b8c7 with SMTP id ffacd0b85a97d-46c0b3e3af9mr4215775f8f.21.1782293579179;
        Wed, 24 Jun 2026 02:32:59 -0700 (PDT)
X-Received: by 2002:a05:6000:4b10:b0:43d:7c1b:b8c7 with SMTP id ffacd0b85a97d-46c0b3e3af9mr4215725f8f.21.1782293578687;
        Wed, 24 Jun 2026 02:32:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1e840eefsm5788075f8f.1.2026.06.24.02.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:32:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/mmu: Bug the VM, not the host kernel, if KVM write-protects upper SPTEs
Date: Wed, 24 Jun 2026 11:28:04 +0200
Message-ID: <20260624092803.972646-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618185641.2022368-1-seanjc@google.com>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued, thanks.  I adjusted the commit message to include Kai's
ovservation:

    Instead of bugging the host kernel, WARN and terminate the VM if KVM
    attempts to write-protect at a level that cannot use leaf SPTEs.
    There is no reason to bring down the entire host; even terminating
    the VM is likely overkill, but in theory a missed write could corrupt
    guest memory, so play it safe.

Paolo

