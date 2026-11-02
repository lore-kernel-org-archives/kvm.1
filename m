Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640781;
	b=tEEGWiiZhfgzsBsAv1RWggyXhN7BSrguBfru6OeWvrk/w6o2dETOMdkkMSVw9X4YSlWT
	 N37HCI4Imk1hzEOF1IYvnw7j25MLxsA7Be71ONY9BnUBfnDLX2tmumJ2q7A7Pi07U63Zq
	 Ppo1G4QdoCqwYr3PdPgPHwTFfzmrxSDdzdHkCpH1eSIl1IB0rcmdXG5V/9HkVGJrM4XeO
	 K0RgK31dDl1gUKcH9w/mKnoSVQPMKaORTYDcpMcXc+eMSZmIGucLwgA6nPnANrAmxdySx
	 wqWBLASTYfTYCb5p8RJvoqijf4429Ciyf6e2HcXW2MZY2WbwBcm/cVTRntdIoiaKVVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Q/jVmLYEpOYFqMSJJPUHM0SmNIpzKPl2Q6duRjCQ5xY=;
	b=Px8t8TYf2gzeQ+K4QY/ilms1VtBNz/ULUMRrCgBQoU9pO7CcZVwC6xIHo6Ph7sNHnY2W
	 r2/S8oC5l76Fppkzk+pHULtyvA1ztGRK9NnImFBDhWThuT7GRlXp0+itBL3Cch+hylL2n
	 wmnmmMRxBfv0NAPI/SkT4sZqMqb2NLDpjArf6cZnler2QxEV1AuO1gkzNQENUJB9qj9Cy
	 26rw75WGX+7U2LpgRMmiGVV24uY/wRpHYrDRvK5aFLS+lAA7J4ZBOtCg3ZSF3nvDdG0nv
	 SeHd/J5GTovjbrIiZi6pLF/ODg9YQ3QXKPqREEaLMX+4LZrAZJh75HuQCLDdry6o9qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vr6Gi2kO;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA797606EEAB
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA797606EEAB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vr6Gi2kO
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-89e96c03cd0so2733378b3a.1
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 09:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793640780; x=1794245580; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q/jVmLYEpOYFqMSJJPUHM0SmNIpzKPl2Q6duRjCQ5xY=;
        b=Vr6Gi2kOMGuTpwT8DmkqTZGp1ia1KpMCjpVHjwWRdnP0ZpI2oH5i36FldXtcRECW/d
         F12qKKjdJFpwwePOq967LfDQ8jYLsaaKb6BMCe4wnpAzO0bnkgm93Uuh02bNSxyVesuV
         DxUXMvj+YE7vIIZ9kyYXYXzuXdLlcVKAzWMNKIkiohKM0cPFXLFuupsEqASEWR3LX3qY
         IZowq6X/ACtDazbPyBlmb3/SX9Ul4zfE+9el0SSK2UZWW/CKY9goRqJovKj8EdR0yuG6
         j/TQ+qYOnlUnZHjBHFkGbYC8wQNISeIQFWkIVolBtl3svm44RBat6Z9ku0qUjg5Lk5XX
         s4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793640780; x=1794245580;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q/jVmLYEpOYFqMSJJPUHM0SmNIpzKPl2Q6duRjCQ5xY=;
        b=EBI+mgXVnVRw2YGMsRt+iDS1IL/d9ZI/yZ6MAh4LJL9ZfKa16aFbX+hCQv9NSTJt3k
         QRosoAe1lBOQZ3oTg3JChQRRHgubV4AzcUCLLtq3C+77xpCUE3vfGPwSOCuBchFxAa0A
         LwuPqEXp9sbFdJ1eAMIMYd/b3fCk0ilxS3abCV+hI2VOzVJTfIi51+3xM6aJfJ4rrZVJ
         y3vdYrT2k5QJM8goTzMQdUEpvqbqqe4gm4AA0yAGNHx6oN+P4NaEU0ZnAF/tFfmK4efV
         yrlFp4MDsKtqBphbyXYy51RCHVNaLLQCGOfYifRmX2Ec2Znz1hrhbZP6wMqOiLNY+0TH
         +OFA==
X-Forwarded-Encrypted: i=1; AKwUvBxJRlYUsKz8CgHeXspbzbyzcekCFDhJEBwz36nmR5KVEmt/6Z4lIZKr8WBHQeI3aDRXNfs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/IBk65vH5VVeXCk8OkbaCKoevWZnnhRYuwLjYJIxzk/CUw7p4J
	zIqqqCpQtUj5pzLQApunUts3ZGgurFmm2cRu5CD5RiqSOiWlm0YKZ7FtXo+d2Efup97+jlCHtjz
	OrsA+IA==
X-Received: from pfwy37.prod.google.com ([2002:a05:6a00:1ca5:b0:89d:3267:4348])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3313:b0:89f:34c3:2031
 with SMTP id d2e1a72fcca58-8a9bfedc980mr10014738b3a.53.1793640779831; Mon, 02
 Nov 2026 09:32:59 -0800 (PST)
Date: Mon, 2 Nov 2026 09:32:59 -0800
In-Reply-To: <auUINwzMTjKCrzZA@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030103643.573356-1-doebel@amazon.de> <2026-10-30-1-daily-reply-0005-kvm-nested-ept-gva-6-18@kernel.org>
 <auUINwzMTjKCrzZA@google.com>
Message-ID: <aujJS5zeGNwnDdy7@google.com>
Subject: Re: [PATCH 6.18.y 0/3] Backport nested EPT violation GVA bit fix
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, pbonzini@redhat.com, kvm@vger.kernel.org, 
	Bjoern Doebel <doebel@amazon.de>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 30, 2026, Sean Christopherson wrote:
> On Fri, Oct 30, 2026, Sasha Levin wrote:
> > > Backport of commit 96b067b59ad9 ("KVM: VMX: Synthesize nested EPT
> > > violation GVA_IS_VALID/GVA_TRANSLATED bits") to 6.18.y, with its two
> > > dependencies.
> > 
> > KVM x86 opts out of stable by default (Documentation/process/maintainer-kvm-x86.rst),
> > and none of the three commits carries Cc: stable or a Fixes: tag.
> > 
> > Bjoern, could you get Sean or Paolo to ack this series (and the matching
> > 6.12.y one) on the thread? I will pick both up once they have.
> 
> I've seen them and they're on my todo list.  I'll try to look at them early next
> week.

Acked-by: Sean Christopherson <seanjc@google.com>
