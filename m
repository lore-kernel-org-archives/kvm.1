Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.253
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213466;
	b=SWtjnriF2vDGoDgXa7R3gQ66qP9lVEZQv9XGBMHVBbBjIdsJ0feDMna9DOMQnfIYMOJD
	 ILnHnnM08dQTeqc8hGcgdasxpN5P8ePqGZDSXsC7jD3Ky6PJ3WjvtbYZpmBnQ4IXngo36
	 8ldigu6VJxAGC0VkMBm0wcOBwpl4ookFzBg3+v0HJscwo/IotMYd+b2Y9c4XntNG97pkn
	 mLcSST/0DhAYZ46WIv9dDYAHJYWhfrBdqy5SlIyUw5WPOYUWOGWMW3+iYpZDfuf0RyK5w
	 2oPG8mLrO7kzRaAFJt97/qMtE0X+o4/YFOvVWUi7X1C4kEaY8pdOlCZfY01KGVTgUzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213466;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WZoDzXkOMT/5cXIMxLO4BLJijoO3XJv8ed+jm9PnUm4=;
	b=3Gl2o9JxwWfIrF1AFV5p0CtMafPuW9y8GzZ0bQmcAmleQwtWtWAb83VYBOCv12idhD00
	 7+1dTzCtX4op/XtADL2uQFkMgACPslDapSCoj6MuaSUCp+lzLBB87K6Ae/KdUj3VZDTu3
	 +dMu+BxPJDZaN6vVOcO4NNGBrO6G1MLB7Lo/cppgXbSBLGnw9dvNUfJL808L+AuZlE/5P
	 bBo+xxPu8SNCLZC5Zm6bqAWn+/kjoHC4+VZN1Yua20MmtJJDjE6GUFEsjKkQ6VUtWaRt7
	 eMJ4cZd3VnhuJLpuTtQcGHegUFEvJH2/pI5kTJBVA+Q5LZwWz91ti3haWpfn1VaiNmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RTM4X4by;
	arc=none smtp.remote-ip=95.215.58.253
Received: from mta1.migadu.com (out-253.mta1.migadu.com [95.215.58.253])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D9F606A33B
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 08:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4D9F606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RTM4X4by
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WZoDzXkOMT/5cXIMxLO4BLJijoO3XJv8ed+jm9PnUm4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794213463; v=1; x=1794818263;
 b=RTM4X4byRzy1SXDFaYAmcHV7jWm8HaQpeM88/ip8OYFy8bPCLa/otCN4ysrSWUHz8Z1c36EB
 Id3oKP9ubd7MAY2ijTybvUegDVlR/wfZ3MsbeNFl530TOyIucEhgrE7d9cGsvrgqeyhH75LdKfI
 kCOP8xvK30uOr5cMm/vqBHig=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5b4a0091992ea107;
	Mon, 09 Nov 2026 08:37:43 +0000
X-Mizu-Trace-ID: 5b4a0091992ea107
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] KVM: arm64: Support SVE in protected VMs
Date: Mon,  9 Nov 2026 08:37:43 +0000
Message-ID: <20261109083743.820111-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105130456.1617185-1-fuad.tabba@linux.dev>
References: <20261105130456.1617185-1-fuad.tabba@linux.dev>
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
