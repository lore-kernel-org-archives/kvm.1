Received: from zero.eik.bme.hu (zero.eik.bme.hu [152.66.115.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0563BED10
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.66.115.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773925643; cv=none; b=W4ehNkiL5LqTGPJ9EKbCMVHkdKYwU1+wDHafDkekwBcpGkbXJno/Q3GO+oxLnwtkenv6X59N5mroWvBKCnkawG3M5vhdyJRv/2ild1EQorzDzyFeF/i+Ma+HodVKFmE2mRmS8h8o5pqKYKyS6xRDE7xk0aMSbC3tOy3W8h7u9+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773925643; c=relaxed/simple;
	bh=vWfORfC5pnzHHdLg7zf15ijAdvvuDhn4lhYbqh+tmWc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=u9FZkpzR4BVPyjPpQ/hbeRyazTdwsLwSj9MGQtShrfukPZzdE47K+TcmyAkwiGbd/s+GkIxfCyo5z3kYgO1Shn0o1Rp1SEgy9hakMgmo9gsPq2/NH12ka8+/i4KAWMv+Mo6MoG7U6jyZrp0MG+B83AL+qtt98AQz7Yin2iCeClo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eik.bme.hu; spf=pass smtp.mailfrom=eik.bme.hu; arc=none smtp.client-ip=152.66.115.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eik.bme.hu
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id DB6615969E4;
	Thu, 19 Mar 2026 13:59:45 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id PW58vAPzBILG; Thu, 19 Mar 2026 13:59:43 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
	id BCFDB596DF7; Thu, 19 Mar 2026 13:59:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id BB33C596D90;
	Thu, 19 Mar 2026 13:59:43 +0100 (CET)
Date: Thu, 19 Mar 2026 13:59:43 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, 
    Paolo Bonzini <pbonzini@redhat.com>, 
    Harsh Prateek Bora <harshpb@linux.ibm.com>, 
    Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>, 
    kvm@vger.kernel.org, qemu-ppc@nongnu.org, 
    Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
    Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH 5/8] target/ppc/mmu: Replace legacy ld/st_phys() ->
 address_space_ld/st()
In-Reply-To: <20260319111936.68041-6-philmd@linaro.org>
Message-ID: <0749ae60-f6df-3cb8-bc5d-b46f4c20995c@eik.bme.hu>
References: <20260319111936.68041-1-philmd@linaro.org> <20260319111936.68041-6-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-2069518506-1773925183=:40587"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2069518506-1773925183=:40587
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 19 Mar 2026, Philippe Mathieu-Daudé wrote:
> Prefer the address_space_ld/st API over the legacy ld_phys()
> because it allow checking for bus access fault.
>
> This code however doesn't check for fault, so we simply inline
> the calls (not specifying any memory transaction attribute nor
> expecting transation result) per the definition in
> "system/memory_ldst_phys_endian.h.inc":

Recently when trying to remove _nomigrate memory region functions I was 
told if some convenience function has more than 1 use it's probably worth 
to keep it. This looks like similar case even more so as the replacement 
is unnecessarily more complicated. So what's the problem with ld_phys in 
the first place and why do you want to replace it with a less convenient 
function? If there's a reason maybe say that in the commit message.

Regards,
BALATON Zoltan
--3866299591-2069518506-1773925183=:40587--
