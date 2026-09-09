Received: from mta0.migadu.com (out-121.mta0.migadu.com [91.218.175.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B960D5437D9
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953341; cv=none; b=MDS33iSvxsglCRT3QOJNqguDvFgn4LMKDyRwHTbRQzd0WyPfDOdsg6RNG/otsYIPfCzyYOoVPx92kFyadBR2+5GaefpQd/GQTUFvuu3s/Tz0xIfWOeA1lQ28cOZppoMEV9V0sYJHIQi2SI2OsQrVUhB/RDyofwoyCy1+IvbWl2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953341; c=relaxed/simple;
	bh=3K+cGIQpWKO1Yr5hRTXgQHb8/73OGKtddJAzidJdgJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u30Tet/saS+GizjsI+OlRB5WEQ0fMBNE8udSWlG8SqffulnVNk6fxYbvIMJBsiHwwv7XBBoEcmG41Yll3YShFqBwJNxv9TYfIMZIRSavg4Y+3WN/MYEzvDFSOd547VXXB6FynBFicFdlxHM0puBE4Oxz1EoSeV8xl9xoD9pSQsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iryyCpTd; arc=none smtp.client-ip=91.218.175.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iryyCpTd"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3K+cGIQpWKO1Yr5hRTXgQHb8/73OGKtddJAzidJdgJk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788953337; v=1; x=1789558137;
 b=iryyCpTdGJzmqAHXWTohRtB3hYyOpTOruRmXRuYhQd+mayeTKu/NSKEx2TFI1YTku3wW8qsc
 B+x3MnXp5hPnQRUqZy6odsT7PYPMAhrXz7ZLVzfConEJvLWSUGrtH2z88Ma5kJalUEawQcvdhT7
 Du6wsksnzMKFBWTI/yPPJjEA=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4a5968a9d33e001b;
	Wed, 09 Sep 2026 11:28:57 +0000
X-Mizu-Trace-ID: 4a5968a9d33e001b
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0b384b7so5898e87.0
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 04:28:56 -0700 (PDT)
X-Gm-Message-State: AFuF++lQoAgUxisHiWSJ1gy+xgDPnK2vic3DIKgTDPn616OlKroklnhR
	N5cPWLG0aUhAYnRGq9aUVpSJy3fMmFFwMD0XIwUMZqY/vXmeK5el1hPiYVfGSsTf8T2edWPzcWm
	vAHEQ7ZH5SKgxIuVLRuRQZuLs/AJPnwLMKV7kKasA
X-Received: by 2002:a05:6512:288:b0:5b7:78bc:ec07 with SMTP id
 2adb3069b0e04-5b778bcee15mr40479e87.14.1788953335800; Wed, 09 Sep 2026
 04:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908162223.1683432-1-suzuki.poulose@arm.com> <20260908162223.1683432-4-suzuki.poulose@arm.com>
In-Reply-To: <20260908162223.1683432-4-suzuki.poulose@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 9 Sep 2026 12:28:19 +0100
X-Gmail-Original-Message-ID: <CA+EHjTybMZ1TORs25En0eb7_41FBcB=BK1ygYPy5cOHUnQO84A@mail.gmail.com>
X-Gm-Features: AcwNN1XnVfoUpkUpC2kOrZN-6IIczUYCQWaTNJXNhIJk8ffOOnhKQ4oEGT6SciA
Message-ID: <CA+EHjTybMZ1TORs25En0eb7_41FBcB=BK1ygYPy5cOHUnQO84A@mail.gmail.com>
Subject: Re: [PATCH v17 03/20] KVM: arm64: Track the type of VM in kvm_arch
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com
Content-Type: text/plain; charset="UTF-8"

Hi Suzuki,

On Tue, 8 Sept 2026 at 17:23, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> KVM arm64 has different types of VMs with all the different modes in which the
> hypervisor code can be run. e.g., VHE, nVHE, PKVM etc. Then there is protected
> VM and normal VMs with PKVM. We might soon add other types, e.g., Arm CCA Realm.
> So in an effort to make the handling of these different types of VMs a bit more
> friendlier to the eyes, add a VM flavor to the kvm_arch and we could then add

nit: "friendlier"

> handlers for different operations based on the VM type.
>
> Keep the flavor initialisation at the beginning to allow for the detection
> early enough and fail out on any unsupported requests. (e.g., protected on !PKVM)

In the commit msg and later in the code (not in the enum though), can
you please spell pKVM with a lower-case p?

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
