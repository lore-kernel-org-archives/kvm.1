Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427353;
	b=NQu2NR/3taahHRJWvP4FnYuA74jUwyISLRRHQvvrWbrl2Jtc2r+UIbDpp+wxFfYHBudJ
	 8ei+k4+wry3wVfOyfAvJue3qYaxt6yoitfscEBMqnaMQXisArqPo7q2TAg4oxrgaAoj0A
	 mb4vi/oe+Uu7NdW5fO44ALUkj3Izh3p79/+v+/6a1dCP3GCjvRSyROQCvWgVmKtvLYd8y
	 U8pYc3fIL7pJUssOVwoWpjeRQ/Q9kwtMPN2Ur4cKXoZ5h+J33vN8wOGtD57VOiQ+GZ8j2
	 9mSNjrp/y2KO9Ortetk0lyoza9EfCkipp94g3jhL8hq50qpWuYpYqEqY/D0Bvbo6IQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=5g6rxDcE+XSPvTO4IYmwgvIS3I7HcVTmR8Q7VnCTKgE=;
	b=ZR7kDgwQoPzVj3+cfAjyPlxJxvvGefGltXUP1MEFnr6ZO5TzaqC6mNjxkgjRFpBMgWas
	 Vb7HBOzkAVMjCVfDiR+K7jvvNAy25n1niSsHnjX8+o1VUAGrfabzVeSqAYIzj1fxWWcrf
	 UIOSim6HAn9GIxWZ/7k5MYir1WK3BA2SNlRuJUj5HKG9ID9rmdyMM7aP2fCBcO2IHs+m3
	 xbVGiWpsitJ6zV8eOSbBgsZ5PWCmSl1v9VwgZf2hSDL2fFRo7uUwjXPV4UYmymaEfXHWe
	 weoPT6Cbe8U1sCN+p+/0PKokcZUpR7iSIJhlCiBr6skrmq4tivDAA6EKG8SzQ15kfoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--mmol.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y+PTMQJb;
	arc=none smtp.remote-ip=209.85.218.70
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A77606A31E
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 09:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59A77606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmol.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y+PTMQJb
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c5101fd59e3so264684266b.0
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 01:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795427351; x=1796032151; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5g6rxDcE+XSPvTO4IYmwgvIS3I7HcVTmR8Q7VnCTKgE=;
        b=Y+PTMQJb2NRM0EXrjo7lt8ZaSyhMbJA8qNIirzqo3mXE6aqQ5VeSkZl0JLv2NWzIwq
         n69UfG0nqzoW1Ewaq1KEdXYUw9aHZ0jMi7Xrl7Gdca9X8xJ/xJvDYvk6CuKJ2KqHausp
         EYKkB1kwgJxi6hKiyi0DM8sAo1nNLLmqlBIsyrcFhkPzI/i6H/7+qL5mj9f9j9860DAm
         87FHPI4XSenuRV3YQ8d2VXDp5NfDC8U7bW+uwL14FSmKU/St4BOt1ZBcPQJUg/EJXNaf
         U7TzDJfHsEnFjkZEG2lrVOoKSEidQ9RbrJVApJBCZDf/d2jZkeGmpKQCiYiVO2rXP1V/
         SlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795427351; x=1796032151;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5g6rxDcE+XSPvTO4IYmwgvIS3I7HcVTmR8Q7VnCTKgE=;
        b=pVIxpAA85YMyEAitvKNTHdMjXaf+ITtGa5B24ePc3ybRDB99CpH3iwDYZ0jtr/dSOc
         vCS2BWxnB3Uj6CFi1FD9lxKMRFnXnhDH9LuGKpCfd+DNQQvlIoiJGaBaZ230DUsruStt
         u9XnSjxaHDkTjgPd8G8sfSO6OUqAkmfoTKf6JA1y4PVblqlX5SMwFWHXq0Mg8hU4gD2H
         cP8ovSwukKNeTMYeyZbXfYBYelFXzdmhhHjkhV9rk6Kw7P826bqTpoOltZoxpy6oBmj2
         8hr2+IwCVWN4Q/ZJJTcupguFzdLX+TMbbTM4uoRYvTeN5VDvVIpF6loEpBb6TalPeh+o
         Bzcw==
X-Forwarded-Encrypted: i=1; AL+hErG95cbCECsI9VmptRvUSc/A1YmREBL6HuPcaekz26j2ojbSkeArD3yocN98H04QajE5JGw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pTrnAx9iR8T9CiJcbwBNkpyA3heN0Q+TlvmIkWBlvGw3v+zPl
	Ja/zaiQAoyCskqxrmhF1qqnUIkvSBpVrADuY+6+SfK9WN4GDrOh0qx3yxDHpRkWK/WTgOBphtQ=
	=
X-Received: from edtg7.prod.google.com ([2002:aa7:c847:0:b0:6b8:98f6:dcc5])
 (user=mmol job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:46d3:b0:6b6:f429:4802
 with SMTP id 4fb4d7f45d1cf-6ba37ea3508mr5728784a12.25.1795427350480; Mon, 23
 Nov 2026 01:49:10 -0800 (PST)
Date: Mon, 23 Nov 2026 09:48:52 +0000
In-Reply-To: <20261109084854.840576-1-fuad.tabba@linux.dev>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109084854.840576-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123094852.2435494-1-mmol@google.com>
Subject: Re: [PATCH v2 00/19] KVM: arm64: selftests: Tests for protected VMs
From: Mihai Moldovanu <mmol@google.com>
To: fuad.tabba@linux.dev
Cc: catalin.marinas@arm.com, joey.gouly@arm.com, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	mark.rutland@arm.com, maz@kernel.org, oupton@kernel.org, pbonzini@redhat.com, 
	qperret@google.com, seanjc@google.com, seiden@linux.ibm.com, shuah@kernel.org, 
	suzuki.poulose@arm.com, tabba@google.com, vdonnefort@google.com, 
	will@kernel.org, yuzenghui@huawei.com, Mihai Moldovanu <mmol@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Fuad,

I have tested this series based on v7.4-rc1 in QEMU
with gic-version=3, -cpu max, pauth=off, -smp 4, -m 8G

All pkvm_* selftests pass. I confirmed that the skips you mentioned are
features that pKVM doesn't expose to protected guests.
pkvm_id_regs fails with patch 1 reverted and passes with it applied.
Each patch builds individually (tested with git rebase --exec).

Tested-by: Mihai Moldovanu <mmol@google.com>

Thanks,
Mihai
