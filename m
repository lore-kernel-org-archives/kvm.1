Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE26257431;
	Wed,  4 Feb 2026 01:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167685; cv=none; b=PzemJe5OUh1HykFn+kox2dvZuX7UdrFED7QICGT9crYtZJwiy7W4kzCtrA3FqD9mVsnVJ9ftJ5msWTM7WXnU1wgeYB3YwH1+dRkX6xGQ8vQXJwaNlydO5k18Dc1l9B9e8+MdaFvDlqxQ5bXae1wZxLSnLBrEOtOm7Qr/WpZ4Vzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167685; c=relaxed/simple;
	bh=gVpNb2FcJnXvqjd76dpI3QbaGIpY5kIyXa8+4pcw7/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTM1oQ9S3ihwgG55h7zDStIT355O84TEuWA5ojyxEQgPUijuVuzIvzp9lsvC1SbbScKNjzt9zcg1zWGPt3tB78BgNV6acJ8g1T9TiAm6CroJIVmE/QV35mjJyvG6mnJs+mcSvkNYKM7gziAxlOXr5KrPHhg/aZbQmlZB7OAMiwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ayOvC/aV; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ayOvC/aV"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770167674; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=kcpw6nzObOocTcTfgP4J3okRdYpVAmfqCq2J3Q4ovjM=;
	b=ayOvC/aVke1G/ZCMMBOP/uGdlIlixWcOs8vLxwIa0DCtNG+TbRl4iuC5W+6ChDV21GBbsFJpiMrVynV6690If+8FEeHIoSQ0EtYSYPNBsH9gXvUnR78f240DSYE22MeJ4J848qr44xE2sYBVokvFI936+AEmd/ZuPeF6YahQQxM=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WyUcCaB_1770167671 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Feb 2026 09:14:32 +0800
From: fangyu.yu@linux.alibaba.com
To: andrew.jones@oss.qualcomm.com
Cc: ajones@ventanamicro.com,
	alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	corbet@lwn.net,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pbonzini@redhat.com,
	pjw@kernel.org,
	radim.krcmar@oss.qualcomm.com,
	rkrcmar@ventanamicro.com
Subject: Re: Re: [PATCH v4 2/4] RISC-V: KVM: Detect and expose supported HGATP G-stage modes 
Date: Wed,  4 Feb 2026 09:14:29 +0800
Message-Id: <20260204011429.64534-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <fazd2fcfuwldtrarm6aw26qa5g6fcieoa35xz3bwchif6qfutw@xuvspa4e533b>
References: <fazd2fcfuwldtrarm6aw26qa5g6fcieoa35xz3bwchif6qfutw@xuvspa4e533b>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> >> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> >>
>> >> Extend kvm_riscv_gstage_mode_detect() to probe all HGATP.MODE values
>> >> supported by the host and record them in a bitmask. Keep tracking the
>> >> maximum supported G-stage page table level for existing internal users.
>> >>
>> >> Also provide lightweight helpers to retrieve the supported-mode bitmask
>> >> and validate a requested HGATP.MODE against it.
>> >>
>> >> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> >> ---
>> >> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
>> >> @@ -75,4 +76,40 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end
>> >> +enum kvm_riscv_hgatp_mode_bit {
>> >> +	HGATP_MODE_SV39X4_BIT = 0,
>> >> +	HGATP_MODE_SV48X4_BIT = 1,
>> >> +	HGATP_MODE_SV57X4_BIT = 2,
>> >
>> >I think it's a bit awkward to pass 9 when selecting the hgatp mode, but
>> >then look for bit 0 when detecting it...
>> >Why not to use the RVI defined values for this UABI as well?
>> >
>> >There are only 16 possible hgatp.mode values, so we're fine storing them
>> >in a bitmap even on RV32.
>>
>> I think this is a good point.
>>
>> Using logical bits 0/1/2 is indeed less intuitive than testing
>> BIT(HGATP_MODE_SV39X4) when userspace passes the architectural HGATP.MODE
>> encoding.
>>
>> However, if we use “HGATP.MODE encoding as bit index”, we need to export
>> those encodings to userspace. Today HGATP_MODE_* are not part of the
>> UAPI, so userspace would need to hardcode magic numbers.
>>
>> So if we go with this approach, I’ll add UAPI definitions for the HGATP
>> mode encodings (e.g. #define KVM_RISCV_HGATP_MODE_SV39X4_BIT  8, etc.) and
>> then define the returned bitmask as BIT(mode).
>
>The best part of Radim's suggestion is that there is no need to add the
>bits to UAPI. We can write in the documentation for the capability that
>the mode values match the spec. kvm userspace can then just look at the
>spec to determine those values and create its own defines (which QEMU,
>for example, has certainly already done).

Makes sense, thanks.

If we use the architectural HGATP.MODE encoding as the bit index, we can
indeed avoid adding any extra *_BIT or mode constants to the UAPI.

Not sure why my replies didn’t go through yesterday.

Thanks for the review. I’ll incorporate this feedback as well as your
other suggestions and address them in the next revision of the series.
>
>Thanks,
>drew

Thanks,
Fangyu
