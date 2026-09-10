Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BABF3CC7CD
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022335; cv=none; b=C25a5fWCxgBTXRG9Xr9MAYbXmNx7xvPPaVh9qFKgkJenhzdXuNoSj6lLxaM28ljYowbuirp2Ov03vlJCDHrRUhS0a8ctFIBR+4oE04Cb5VmD7lfWmHG8b1FLUQUUsOaAOGIsBbTbSRYsmHwckUKKY2GAMLiPaSejvEwmeZZL3Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022335; c=relaxed/simple;
	bh=TP/7+E4rrU+pDYrVqTFosm4KeNM9JoqKXMfQYJNgxAE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=QY2Fg3T7ueZxO0+ILogsyVdtnlnij2OErZ08cebU8hJBZOfEnP9GsEeAmbZa/KGVxt7XBxRx/Bnm89WTM89FabVKuQCnX90OGTjw1DmwNIW12bvgIiTe3RJxuCBDsXZvPOnUAXxeK9Pppje3u1NI3IMEtq7H4iVZ2V3RK6AyS18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3rEMY5z; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3rEMY5z"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso8004557a91.1
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 23:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789022332; x=1789627132; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TP/7+E4rrU+pDYrVqTFosm4KeNM9JoqKXMfQYJNgxAE=;
        b=C3rEMY5zQpJoUyUIRSHpprr56mpVbR3wVWT34RtYT60GoXPTdkvU8gnc2zd7WLzaRu
         itRbHwRMPPH5jjYSq4T0+4OtV7ReuHjE6ga/KhxlRoBBAAADxmSxkQEm5UCaXWTl1RL5
         BXhUaL6p/aQIm2hoaH8Nbus0qAem3baIoIw/vjHo85oFeungf4i1RlhYrHJiT5+qKtnP
         o/3D2donNSyAvWNovO7IilXHBPTTnXCWX1U3Hpv0MhGuJDDBgqooVaU7D3fVb4+KGi0X
         35bpsnsiKkr1vAX6WxTMCpZv4wbVopVDHAFxun7A7Fx20ttVxrAOcjnKKmSgiRwrUfFb
         Aztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789022332; x=1789627132;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TP/7+E4rrU+pDYrVqTFosm4KeNM9JoqKXMfQYJNgxAE=;
        b=OnSxdfF3EVUdOg5amFxvnb34EO9ggIkxhhDW2jzrE8xIcux2ufnC1Ubq7x2XM3udVP
         PRjXseJJh/i+vrQnQQPdOGL+bBhsJNNQeM9LYY1vxL/BlwJmu7qZ2yc1M12CG345F3XV
         VZ1RloCdtIPEybfbdkRfH3a3RZ+kKu8atZQ37zRZHRBoSuRv9LyIba8oF0oyaApgV5XT
         +jtVYj7nDMHD01SwBfmHX6e4tkR/kK4hmJqavC/qr++xviF8LBlAaW1/MJPe+Yv1Yqgb
         DfZlAiqqm36pv5pRriD0dqtPjGo7sq3hfwb51+BGsiguANsFQxgundGKgB8rBqGzdq7W
         3zTw==
X-Forwarded-Encrypted: i=1; AKwUvBzW0ybtLxolqbBRbTDKLavSUENNa86BsdHFu2VL+zu9JeQPxBq3fPOs2J2EmB+FgzttYp8=@vger.kernel.org
X-Gm-Message-State: AFuF++nogP3pbhaCue2tkTUXZP1mnN1befoBDnuMtyMKckV1tOs4fwm4
	sjwXxV/HNs3hYjuH2Yhu5IzAu3LX56WRDoZzwhNgnST5JURoA4JF+liP
X-Gm-Gg: AYBFou2avVgA5rZmb5hqxD5hu+f+cNUJBc7Oytj3olbPlYyxCK1UdM8Y5Vkh/g24WV1
	/z3DZWY/HNxYEFRDUi6Q3om0Lb4uRzW/0aESUBlDelW3aNhNe4StPG/y8ftREx0GC/INYPoi+Va
	2il2MM5fllWJIlKf+aUue/+wQ4hh7ncuk2qB+yIOTYe03Hxpgz8TghJzMVpGzChVUZGWYm7YFYs
	B73LVFqhfiHP1eDQ4l15faQL0seHpltqrii2lVMBRq50IlDc7YShT71niKwbUA/0+q5mdpYC1Hs
	oHFm40svbvvPpzJWHw7vvptqG4kL9PEihPcoyEum9IBqP8NzAj6hq1ZvIpRY2PKiWpH+wJdGZt9
	q3HXTl78DIMSECJTS560sih+7ANWnPnTfXHJT0xhnc9q6I7PzUQ7/pbL38OALux544CFuvDfsx3
	PCbYptJvFP2YgL3xS7hVzh7Sa/IxVpo54gRoZEjulXmZFnFMnmkWIgnwoDPCKfHHnzQFRpfOswc
	lANLpabnMQWsDBkjlhVMs17MyFGbRbzuvjDBRdsV77lW1M5xjMVIhJfdOsZ0DeX9Q==
X-Received: by 2002:a17:90a:2c9:b0:39b:2b5a:8dc5 with SMTP id 98e67ed59e1d1-39b2b5a9b24mr38222127a91.6.1789022332072;
        Wed, 09 Sep 2026 23:38:52 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33987ccf483sm10464300eec.20.2026.09.09.23.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:38:51 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 07/20] KVM: selftests: Make the single-page allocator APIs static inline
In-Reply-To: <20260902164123.2546762-8-seanjc@google.com>
Date: Thu, 10 Sep 2026 12:06:11 +0530
Message-ID: <ecf11ulg.ritesh.list@gmail.com>
References: <20260902164123.2546762-1-seanjc@google.com> <20260902164123.2546762-8-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> Move the single-page allocator APIs to kvm_util.h as inline functions, as
> the are trivial wrappers, and unlike __vm_phy_pages_alloc(), are expected
> to remain that way for the foreseeable future.
>
> No functional change intended.
>
> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

LGTM. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
