Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213463;
	b=LndHYImMD6TMTqei2atSGxWWCjhaHRWt9y26J4NwGNTwaqfK8v0L3B8Ttg3CDHry1TFA
	 KjzW3VYlYSXSNAvHGYywrijIMSQINShgxHGn4WRf/sjsPcqWBOgfHjnMbDi+5bQHj7UTL
	 gvViKTt5QLuptU7AlxAre7It+4CzbEW61btJYGTZ7HBHPT1MdlFdHMVAKNbErfM7i6+2+
	 p9flvIAko3S1ma6GVTASMvfryNdjmzjt5yhFVghg7REx/sIdjbgzGlfmlUnFKDgqCwxoL
	 34ls5w/CfxSqdB0q02rhh8a7EsTn2SSymgLL4qMtrH5JUJs9INI8cOVTGgBkPERoLpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213463;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WZoDzXkOMT/5cXIMxLO4BLJijoO3XJv8ed+jm9PnUm4=;
	b=L7UnBrWhsoK78k/0145rAoNPXf82PW9UMxde0oZH9a17nWwqDQi5XhIhQt3FE7hcJ29P
	 JsW1hxy+OWR64+qmyGatk0zcU/4cvSjGqBN9tie9w9PeofijFmFFOwOzNACgrprXwz3Fm
	 GqnMpCkHM9aTZIkG2Kk3HxcAN5VyBHMtqPddaXY0qZR6XIErovFUvPurvnc9IOz07IBef
	 dEi+W7tgYEJ4CdDCDLOi5HaYvQb4vep6jthcUHklii+pmz7AigKzDV4cei/RoY1dcHGYb
	 AwckUEvjckaAwMxgdvmwPty0RWyycaY2PR8YrBO9RklVQZt7K/+eheZRCfnvrG88h4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Seht+aPC;
	arc=none smtp.remote-ip=91.218.175.38
Received: from mta0.migadu.com (out-38.mta0.migadu.com [91.218.175.38])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0E8606A323
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 08:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B0E8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Seht+aPC
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WZoDzXkOMT/5cXIMxLO4BLJijoO3XJv8ed+jm9PnUm4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794213460; v=1; x=1794818260;
 b=Seht+aPCpyOK5KXSCO4hctGHBc83Pf1IX6evZliw9wXT2hzR29V45R45VqIyXZvoU9lnx3m9
 FGpE/7CY3NjQY4gNCEjPSt0PIHJjneKfmoxjLnu05U7oPF1VvdOkcgPppVOik3UhpchyIH+Qi8J
 a6fIR97+YZu/Rwi7PALL1ITE=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d92dc173b9474008;
	Mon, 09 Nov 2026 08:37:40 +0000
X-Mizu-Trace-ID: d92dc173b9474008
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Fuad Tabba <tabba@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Add support for self-hosted debug in protected guests
Date: Mon,  9 Nov 2026 08:37:39 +0000
Message-ID: <20261109083739.819288-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102093950.2922035-1-fuad.tabba@linux.dev>
References: <20261102093950.2922035-1-fuad.tabba@linux.dev>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

I've folded this into the series that advertises the rest of the
protected VM features [1], so please consider this posting superseded.

Cheers,
/fuad

[1] https://lore.kernel.org/all/20261109083205.806619-1-fuad.tabba@linux.dev/
