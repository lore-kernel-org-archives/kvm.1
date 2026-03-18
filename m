Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DB81DDC2B;
	Wed, 18 Mar 2026 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852818; cv=none; b=WdtnuxO/f5xbPUV7mZngC3//IoSHDlu2Vhy8QLxeqzOsc27d44nl2iVlznovGKbZ2hxKv5InhbBWUxgx3NP/UWCGDHpiPjInZbW0ummI3h0sb9Yoxsynk5L84LDs2i6q8I6290bvDkUGUwr5fj0CSH7XqjYMTx3ATIEkPW75vxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852818; c=relaxed/simple;
	bh=fsbipT/a8yrl3HeiZ2TAuTHLKHSdkAl3PK8pZp9xprY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AyOy++m3n8lpEqNYHF32+1oRpujmGySaFJi6MDHtAjTEAjK4GzTg+MuzNzl/L1KlQjTRwGwBli1TMO5hI8oV7vuoKIR0w2I1cuGuGEpQn6bWk6w97NSROfpAzIYtwIrPyVi0tcf8HEA5jzpkuFu2wbP0Omu2lHya4nykCmGQq7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F4351BF7;
	Wed, 18 Mar 2026 09:53:31 -0700 (PDT)
Received: from [10.57.61.122] (unknown [10.57.61.122])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4D173F778;
	Wed, 18 Mar 2026 09:53:29 -0700 (PDT)
Message-ID: <6e7cd05a-2859-4225-a50f-07d62f84568a@arm.com>
Date: Wed, 18 Mar 2026 16:53:25 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/48] arm64: Support for Arm CCA in KVM
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Gavin Shan <gshan@redhat.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 Alper Gun <alpergun@google.com>, "Aneesh Kumar K . V"
 <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>,
 Vishal Annapurve <vannapurve@google.com>
References: <20260318155413.793430-1-steven.price@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260318155413.793430-1-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

And for those who like to use shrinkwrap the following YAML config
should work on top of the 2025.12.0 tag to pull the various repos. Save
the below as e.g. cca-v13.yaml and follow the usual instructions in
cca-3world.yaml but refer to cca-v13.yaml instead.

---8<---
%YAML 1.2
---
concrete: true

layers:
  - cca-3world.yaml

build:
  linux:
    repo:
      revision: cca-host/v13

  kvmtool:
    repo:
      kvmtool:
        revision: cca/v11

  tfa:
    params:
      RMM_V1_COMPAT: 0
    repo:
      revision: master

  rmm:
    repo:
      revision: topics/rmm-v2.0-poc

