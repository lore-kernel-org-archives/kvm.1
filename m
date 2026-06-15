Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EA2413221
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544281; cv=pass; b=O46EIBK5bjVEZa187uvs/VdABwNVJPSeQsnxmPDDw9pV4fBdLms1gW+reR6ynjLW5K3MhcR4UytSfdb61+FwtnIToDrv9C4/dYPreTXwtWaq13fA5lcDVgVv8p156EGiSlNJDsDzmNTfGgS3ZLAq10vnVzljUp4YZDvMWMm9cvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544281; c=relaxed/simple;
	bh=glq/fqqO6f4hat1gGm0hVpCWMExv9mbKFuwcUscTT48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTTSOqCk45OMP/sT1ZR96Ff9eR4CzPxtIyuSP2QfmQyMwfnaN28pXjvcWNCUk3F01uTxLHSfY+04MrfcVez8xnTPJQ8sZH6pvLt6EZxmZoT37YQ3/yEzwx+pbk+/C7MM0n2fo7i7vdLqa99Kw4pv7hwcEpgpbUI0I+Eq2+u58zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f+BPdGv/; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+BPdGv/"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68cb445dd5cso645a12.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 10:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781544278; cv=none;
        d=google.com; s=arc-20240605;
        b=eY8AYCB2isRBzQiY6Y3YZoPJtm8+mcMyC7y4qfjyqjnTbsNWHPrt354mxoipMGlWtT
         4fMQNBbHXIao0MRl+OQt56R3wDf3ki/UylAC3PWtRVH3uPgjdvwLRPxjQKJb/uZ94TIV
         AKkXaXe5+e949PbCFZFCO8FZWEN7OFfSfX7gSkerV40T5+tuFLMxXVKi3CFGh/AOS0fr
         G1//U2kdXEkzF8BCcACFAyVNMEEdSZrWIF5Y57zga1BZTg2MGWjaUP/hx6kfj2pSoTJs
         T44KBbNykM1UXrLwkP/hC7t8qHDN1AzcTSpiBfumuSjQpq7EOa2QF4zvy+7kUjc54R6s
         zaJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4dmDgMbPiDzakGMErmzERE54PFK/ueHUWU5hgu2XElo=;
        fh=a+SYs5DKaW2FJOQfZ3VlqBo9vl75XZlv4PyHlC411zc=;
        b=D3XnTUcA5a6QdUgcBdMFLeCjMw8BY9K/WRvZTDjkIAFVCehpY8Ikv5hTlD3tVZ6ZTy
         Ni5McDB0mVuIPIh4DujOyGtuMzxRluq88XkaAiYSizGiKetoubUgDHXnPcsQRL8FYUw/
         NFhHzHAYd0X7KB2qypRUvmEiWV1gDSTFUyKoEy0PtqE3xc6mkNbfPdKZT9F91K3bA/8B
         VRAKgt0qo7/xnRGvCfHP0QdHyDsqy1gkCy7VRCua4q4uAVEOl1NPTSHLCNGzk2jLQ1kA
         63iN2nXZBxCHKUCgPQ8e6GlZolylf5YkwFhbcwH84yk3nooyOcooIPHlNhHjXccNzPIx
         Ukfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781544278; x=1782149078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dmDgMbPiDzakGMErmzERE54PFK/ueHUWU5hgu2XElo=;
        b=f+BPdGv/nqmla8LK2ZcdfL5UowggQftUFSKT9Qyvb8lNv321yfa7C3Ab0bjaBjyI8D
         JLyPcBkI2Z25FbRQ9u2siKOkK+WYWB6qEJj+ooCb8976Ht0aR0dS3EfsKpCMXSbSlXWr
         hJCwP4X+L3/C2zuBaXaCsIIb9O8y5aMNO1gLTGshfhg4ilucaV6ZzNsmVcD5yti5TE3t
         NWQSlq+japr16JFE0uSv0fMgT8VNObv3i3M9Ujdt82myjwBouXEgQFMZh3mIJtjZoH1i
         wymN/hteskTZMa00kA5hkXqB/XKSmGWP/6xm9kkK7LRTgKi5m67h/sHNyB2xUkr4oRI9
         GMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544278; x=1782149078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4dmDgMbPiDzakGMErmzERE54PFK/ueHUWU5hgu2XElo=;
        b=mKazukTbll46aoc41vFNGz+uru1czjyNGUEJ/UXQ7lXmEgTNY/4bKAx5g7uMe5J4da
         0smzYcYeIuyETIcXoRmrU9ANNNrWgHXVVCDLm9Mn+yKXdILcjd9cOkuXM5qJoxrD2T9D
         9xM3Mb8fvN1GJJvX3u/SJroGOyxIvw/cBZY2gLQdRkol8TOIUj/C5C4AseRQjIzeIkMK
         bwqxgoZq2x9pte1TKADoRxVpBPolW/EPGOEq1KIU+9ZaXCkBdJXI//rle41vPxgJNwc8
         P9g+sNfeSPOVhJ9CKaTxBDwu49DZowMPyF5dF8aevg5kYo0vm1Xpwsx8FyGQdmMLgQfF
         +pVA==
X-Forwarded-Encrypted: i=1; AFNElJ/zlCmdbsBuHbDL2UZsTUi16Usy3X1GDPqq+XT3c1PUZavxSsNcIl15lF8D2UrLayOHjDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrsHiCy/2gKNXYyrzWXMmpllUTVliHqdOtNgt+66naW3Kuwppc
	8J/K9l38w05z1Tee2CKe4mnBrVwC8WIRkpXWXwcF4Aww88V/fEbpE14A6U6g6x4SV4uo7goVFQa
	K/WVGwv3NxpP4ScnkLrXp27lm3NnxYxFKFAB+KvPH
X-Gm-Gg: Acq92OHixirZTRV3J1EuFFSdROwT/MYHr0fPAbiLp03QPFfp+aDyqftwHKnncDHiqGo
	c+bNW6lj7ghaSK6sEGUrCSfkW/KxHf0w7jWO+HegZxT/xEPIkyfyLJemmg2hGhK3bup4lrbnToS
	UpOTARbwQE7Pj3f2/wgx1d16WeJHKMDEpcm01LhiBNgaL+Kas2p/ptwppZQogYoTS0lT/VhOQDt
	OtAtU06p8oTrSF39sssCnzMNByPztW2wXspTVpk7eBfXWLHpcphxZ5yYHnFtAYnLl8lQlXc/SZH
	kB79V8g=
X-Received: by 2002:aa7:c88f:0:b0:68a:83c2:9c75 with SMTP id
 4fb4d7f45d1cf-69508510539mr2982a12.0.1781544277830; Mon, 15 Jun 2026 10:24:37
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612230113.684301-1-seanjc@google.com> <20260612230113.684301-7-seanjc@google.com>
In-Reply-To: <20260612230113.684301-7-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 15 Jun 2026 10:24:25 -0700
X-Gm-Features: AVVi8CfJF4AiC3bufnnzoUavmSCtwwDHcX-qUL-RERqKPo7IWSzXuZDEcvXdtIY
Message-ID: <CALMp9eQuoKtDioQe9FAFwJRew0sj6Sdg3K0ig_aArB9kUC1NXw@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] KVM: x86: Use kvm_dr{6,7}_valid() to check
 DR{4,5,6,7} write values in emulator
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>, 
	"Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 4:03=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Use kvm_dr{6,7}_valid() to validate the incoming DR{4,5,6,7} value in the
> emulator instead of open coding an equivalent check.  In the unlikely eve=
nt
> that the behavior of DR6/7 (and their aliases) changes in the future, usi=
ng
> common helpers will hopefully make it less likely the emulator logic will
> be overlooked.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
Reviewed-by: Jim Mattson <jmattson@google.com>
