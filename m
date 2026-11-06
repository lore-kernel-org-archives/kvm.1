Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979608;
	b=or+3NaBbaZ3/wKuWhqGIb3WtuspYN9O0tPlwitdPu8k8y1sNSeUAAML0yeyMU8YLUb2I
	 ArbTXKJ+LtA26vaKF0foRT5KxuUVNzpRaUNBiRXegM54w3adnJm8cQTkZMg+u+9A2Yxkm
	 AA95loflCYqogpJb1v9QtvhGT+9KZ4VqqHNIE0hVhU72KDbXvvFOpXHihp3KQY4VUSrm2
	 P2zYwTCIVVHqqywFLkdfIPkVygOfoKFIJjhUMzmtBjlES7XNXnXzG7U9ftfISesAkXrgZ
	 GjoQnypdYVQM2NNQud7tgzfUfJeVFPfDRH719NBhZe4e9hkKLFB0QC7t1sis1L5BbBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979608;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GjZxu266jNxwcR9mDbLVKfmtb9ofuqlgjo6mMVq48Ow=;
	b=yE9noc+l+jG0KObbf8p+vmFTfypO+7px8RmV3QHi7uUudBhzMtX9g7yvuOCrKeMWvWrr
	 DIS3yjS6lPG1qvXSe/EGnrt2crIqwHCZXz2VtC7LjSHZtDdebpIZDqtl14wKWkFxKL6Sa
	 YKPGMCRy5Yftp2tkncrHqfcvxRefBRCvsEHNs94auG0HkflMufm9B1+0gdc6U9q0wwWyi
	 54s02fvvxfT9Bx8517271frRf2tKOxs3SM7wJ07gWWpCrqXqkvThyTglYBDLi+Jsedtvk
	 xZ/hjIcsqziIbea7dqVJ1PiQIzicxQ7aySgSpszfEZKR0pCQ2eggGJb547C0kwO2oZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b9PcMiN9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB29C606A332
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b9PcMiN9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6016B1F0089F;
	Fri,  6 Nov 2026 15:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793979607;
	bh=GjZxu266jNxwcR9mDbLVKfmtb9ofuqlgjo6mMVq48Ow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b9PcMiN9Eyh6Y1nHv0j8ZdtKXqS+JtGE65/ANJNbJxbJakhtJ88RjlN98bI8HU3MJ
	 2CGoi5X4r3x8NFx82QCEfz9ZF+n6tqxfENn2pXm0zhkavCSf6MvoiF5IElJVSv7EEf
	 Eek+g0ERAlNMXzeYYAj+qJZS8hm06GrsgqDsQQdQ8pgJ/BU5JTuWsaEll7ToGPztdH
	 07gCnA0qfIXDVyYysvpS6PnDcyCDCD9ubwHf64vWiYcGUHG6w8LgUAIWQ94mD34Qj+
	 KmXqEB3O3CYD1DGEhfcARS/e8Q2S/9nnbnVEQ6HRk8viYUoPpWT1TkZB3kZmoronwG
	 n7MtlykGkdRjA==
Message-ID: <sashiko-outbox-201715@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] powerpc/perf: Update prev_count of event to get
 accurate values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gautam Menghani" <gautam@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261106153136.330165-3-gautam@linux.ibm.com>
References: <20261106153136.330165-1-gautam@linux.ibm.com>
 <20261106153136.330165-3-gautam@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:40:07 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] powerpc/perf: dead store to prev_data from local64_read() in
  vpa_pmu_read()
--

commit e6b6a01ca205d4ad136547505bcf1dcf984b82ba
Author: Gautam Menghani <gautam@linux.ibm.com>

powerpc/perf: Update prev_count of event to get accurate values

This commit updates event->hw.prev_count in vpa_pmu_read() using
local64_xchg() so that consecutive counter reads accumulate only the delta
since the last read.

> diff --git a/arch/powerpc/perf/vpa-pmu.c b/arch/powerpc/perf/vpa-pmu.c
> index 01d9196fcb0f6..3296877eb317b 100644
> --- a/arch/powerpc/perf/vpa-pmu.c
> +++ b/arch/powerpc/perf/vpa-pmu.c
> @@ -132,6 +132,7 @@ static void vpa_pmu_read(struct perf_event *event)
> =20
>  	prev_data =3D local64_read(&event->hw.prev_count);
>  	new_data =3D get_counter_data(event);
> +	prev_data =3D local64_xchg(&event->hw.prev_count, new_data);

[Severity: Low]
Can the earlier local64_read(&event->hw.prev_count) call be dropped now
that local64_xchg() unconditionally overwrites prev_data before it is
used?  Because local64_read() expands to a volatile READ_ONCE() load, the
compiler cannot elide the redundant read on every vpa_pmu_read() call.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106153136.3301=
65-1-gautam@linux.ibm.com?part=3D2
