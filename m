Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F9B329C60
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 07:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581790; cv=none; b=KSO2gMPQ162iDuLbQgaLgDJTVwzpdWk7WNMF7kWfCCPfE2KuhgcldTb3d4mPhQUhIt8QNhpjVMzHMuc2IbDXXCmPTTu795nTztrA/VTWKGr8ESJVWkf8QUQIAr+WZm+Mh/UnHu7AlXh4finMYO7HU8mGeHCsR4h7pmW7RtmtCTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581790; c=relaxed/simple;
	bh=JbFs08RRpr7vxGgecJoKdqem1cuqw4Ey4UynMOerw0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7/dJq58HZ9EQZNMupShJT8lFyvbvl+Fx0h0FZv0fTjT8Qb2FV2R4q2dNFFWzTM2K4Q+EP6+54ALDGQ4Oc+KuEi4SvBllB8DYUEj5rNMFMd8fh/NnZxg2dMe6jbCkMz8uiqHMIynyWl0JYqGtJmMPDHtTPxsj0HGhHmWZW5l5A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wty68I4R; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wty68I4R"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47d70879764so1035902f8f.2
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 00:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783581787; x=1784186587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JbFs08RRpr7vxGgecJoKdqem1cuqw4Ey4UynMOerw0M=;
        b=Wty68I4RQYHZjlfimefxa7B//ooHgVsRIMqSECe6xGpKefQRK8QphCFtj09PIS4esH
         oDeUgnH+vNWSD9eAvwT1HJrXiw8TyAdmowhkZr+RPxuuWlnRPMdoEgRWQU/oqHs6MOMU
         H4Y/eG7GSXveKbmiJfcVhr1thYHkikwluWgK8EksiBV1cvY2MDhQSFpXUpy6Tyshy4KE
         dP9zEbILcKhz3sRu2Y4M+fb5IyAIGC0Rkr+2t+z8BYLy5fGvNNpynj+Fl1oDnbNZq4ao
         Zi0FlWfhgZk955/20kOtiTuXCXXX6XN4URmtaYRaR7lYqmkuGrW/aAHoDpcod/jPKcTc
         pheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783581787; x=1784186587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JbFs08RRpr7vxGgecJoKdqem1cuqw4Ey4UynMOerw0M=;
        b=faCHyMfSp6R5aGK09vvdk0yRRM3cRTPaOBmGzG5CldX3Onjp8NSupvcFhCo/pY5fNA
         CDpUWXC8LHUH3zoWgYOO73w8qlZVEcO5l+stB/FgC+vlKHnoMzWog0dy6ApixXCaWbIW
         a6lslllT6bgdHiYbzhLS/klwsu3ZXk7uGd8ogBQt18MWFAvw9hIvdvx3FVzBSmp6QWor
         BedeA23Ya7/wrTeImVaTh7pdgXpyhINz+I/84npI2gHvBbWxyFCSFCq7KtIuVMIqgSFR
         C7yZZiYhKH7iyOwZc1o9NAy+ZEmCTlBoCxJg12qayiUH/uoyLH30apjOV0HVkqqgqrq3
         FdNQ==
X-Forwarded-Encrypted: i=1; AHgh+RqiurS/ZhFCLHZjzS9XlfP5eT0AM6cx68Z2Uz0T7XQzV0+uICJo3YDli7Hlm/jfiggh4l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFNFHVUMBCdtnXyeWrcSPYNKGxrxoxZ5rsLLIRLzbwV8v8h66J
	PB0diMvUNkOhq2QVQsO+91hitT+leglSBesGoZ7/bdrZFoCG5W1qfoqZ
X-Gm-Gg: AfdE7clrs366XnIyZ6zdpeCVJoJQFgcsx1EAsovwd5BabFGdVK/HQvIAlyGaoBkp4RD
	Ru5tgSrkjqkEiU1ErMjRLfJp5OfmgwEXtO8h2uPkyowCav+c+ZEH6mfLLg7eo3q+erqNk7BT/iU
	IrSD7ymmwpOaEBEQr0BXLpkq/RUjferljh6xSEfH6pfAWSuk5c5DfeWxhVCzNcyKIVEa9qVWo8K
	SiOjnJRVdUXxBE58kQlng1GtxxuM5LC9E2fz+YEa1ZMoVGXZQN6l/xZ9W+47wu6QvCCjVZeD30K
	BekTrt0RunM6qZqBZYrPX7N7y25YJbQ74s62HriuvbsUVDqmMt6bXAXJUBr4dbrVandqU9pT8mv
	1yBPPmAi/9Kj1j4TiKdGMwXP6PU3sbhht7J5065bS2oel1qepFy4ar4DkhK0gudQkFJWcFl833h
	xHysM95d9KBPuuH8Xg87UfOXWvSgKSQVMvWJ52GcrP2ad8Zb52i6VW1fAvf9ukh08ibxgB+xrr6
	U87b++VK5g1cFKpmXis8Yk9HeUyZEuIiNQfApIOCINVpVvBuib9UZpjXD7HDuOmBcU0pM14kB6j
	4MskU/CU08/ipEeTxw==
X-Received: by 2002:a5d:5f89:0:b0:475:94e1:29d2 with SMTP id ffacd0b85a97d-47df07a952cmr6389085f8f.2.1783581786635;
        Thu, 09 Jul 2026 00:23:06 -0700 (PDT)
Received: from z16 ([2400:adc5:134:ba00:f774:65ea:79e2:617b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960b06sm48213151f8f.28.2026.07.09.00.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 00:23:06 -0700 (PDT)
From: Salman Farooq <salman.farooq3310@gmail.com>
To: ritesh.list@gmail.com
Cc: chleroy@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	salman.farooq3310@gmail.com
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Fix comment typos
Date: Thu,  9 Jul 2026 12:23:00 +0500
Message-ID: <20260709072300.46466-1-salman.farooq3310@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <8q7kwssv.ritesh.list@gmail.com>
References: <8q7kwssv.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Not sure what this will really get us and what is our maintainer take on
> such spelling mistake fixes. I definitely hope we won't churn out a lot
> of patches just to fix simple spell mistakes.
> But FWIW, the change looks good to me, so:
>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thank you for the review and for taking the time to look at it despite
the reservations, I really appreciate it as a first-time kernel contributor.

Salman
