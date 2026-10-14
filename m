Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613ED30C345
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 23:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792020715; cv=pass; b=OXms89mTsFLdwbzbSsZ/TqoZpAuuJJApl3laLSaa4ovgtzMX2dxQY4SjzwXI30u8mHVPNnpHJzhi33FnetRxIaZwzFwFFAxDqrK9LV9FIk+G23DR1DTx43/K4xwUBweftC8rhTniqnrTfOL0aACus6ecuXuY1uYckBfO0Z0YC98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792020715; c=relaxed/simple;
	bh=c+5SN4BUGc0cAYOqueGecoLgZhbCt6m/n0efmhJQ8/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGGR0OAmJyTsxOveBUxRMvxOee1W7ndSRU+a2fgH6ZaZVGANNQdUvCCO6VaDNLLyKmByFjKev5crhTmKUJJQ8tFGHez9farTh++OKIvPpryQaQcteTtSI22co0jxhBmjHMDUWX7Pf89jdb0YLI94Kmajj/frAWGCuVqJ4TNsl5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OSKetn34; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OSKetn34"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so1195a12.0
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 16:31:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792020712; cv=none;
        d=google.com; s=arc-20260327;
        b=VPrF7VVUvX+M+yZx5F0dTmPwtBVjOdqz7ubV6cwx1Lc1ONLmJnGfk/UuQiauDqHAUT
         ynMwt8ZDaSokpY2KG619e93G+4sdhRG7TWxKtLm2fuiUJYiAeI3RPoR8kUyJna09oUO/
         eGT4KrholZEA31aIBhAM2Gehs3M27zhFwMgKeONZzfvyT1PHpi4I7hAHBpGCpfFS83xh
         0DJN/X3TQSAgvvFJw25vlXjYyzEi/wswcBqZ+Jvvw0w4eqWubJD0okK1usDA07BnFf4l
         E3IxZP+QMr3VWW6t72cJL0z27wIoAz4qvaYkCCCWau44DSuUkieVX9NAq9Hz/oAJv1VH
         JJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c+5SN4BUGc0cAYOqueGecoLgZhbCt6m/n0efmhJQ8/A=;
        fh=LXwTa9QsmLiG7autefsKO5jfQetlvC3/3wixhXZqKjE=;
        b=E8iRaQ2ydEcszwGWyhHUZM6xa0WWq3ilhQdTnvOSwwbXSBXYDIlnWGvVrAHIC64WCz
         qdKzhOi6919zogqV6jzNeBaDVOXt0nnVfkk5pYF6gpFx8gi6fweIp+PKTlVt3QyvBaIZ
         8hQ8H+uc832A+g2L0iySYI2ptiwGXfStEO4NAgEiwGLFPdyAu3q+LAgWaJTBQeQGPTP9
         sB6o3eoV0vM9W5rU24h2Yz+wF/HL2ndf0yqE9m29CziJ3jvBAiMQxodpr2cGVGOu0yAL
         XA4D/leXyOlUbZsIdyhGoFbCrPYveR1Ohz7KF93csmpgFh18tRZrBIH2hPlvveyRG4U/
         RYPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792020712; x=1792625512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c+5SN4BUGc0cAYOqueGecoLgZhbCt6m/n0efmhJQ8/A=;
        b=OSKetn343/ILNReqXFVfz7BB7Yb2YxRsdHFPS7lHsXtKqtgfHaiXpBDd2qg2uqfwiQ
         YLK68EiDVxvl81HAjhs0OIEeAxy1fUvyU29WfmPmBwGeb9+FN3z5KcqMiJ9g9yGmI8HN
         hcXdkxCfRVLNt66LqtNg3yaOTg8PkQ4iUSjGCogwnKw7gmXl+yw/Q6p6JniEg/MrjNp7
         RdNHNsEflo5H8G5oPUkj33IYhtR4pJ9Viybcdj7d8PJgeTvCeOS/aT0fsfOLddfzpVQ3
         xAPBKrjYORzOeKda07wh1EFcIFlx5VH1x2CqWUYrlh/KV8WDoxwmvnSNnU5GOnofwb9o
         aPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792020712; x=1792625512;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+5SN4BUGc0cAYOqueGecoLgZhbCt6m/n0efmhJQ8/A=;
        b=1Vo3S500Xnr/acsoQKwGoaANnTbOg84uZw5qk/rQy6bm7d0kSzemCd7cXo04HrT7LT
         7zSjuYOsi0R3DnIkLOy8PLLZ7JUgsLSmKD9rfRDE05Wz4xDI1aGof3t+whV3Xtl9Z36f
         NMoEoXbE4OZItfj3Q5vlRqoIK/IYlfzrA7Qcf/zBC3k/TaDx4DES7MsIO2+7g5LW0ldq
         I9MC0UmUAcgp46PXY3S5YvKBoKkwyRKY/0IDKadTOf90OV1BtwsWtJnrVM4zR5jK9uaA
         sf7fgCqfbllJjKiqRddaVnNMV/UQeFN9HWo6D/Vu9ZmVzd0yC+PNjd2MACbUggbMcjaf
         kcTw==
X-Forwarded-Encrypted: i=1; AKwUvBx5Gy8tEPjBDI8Z+yHypXFYn+H0cL2HskGH0F8+wxrFPxg2iZDgcsHk8RtzNQQrSekureA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKCmvztXs5LsvoML2nImROycdq4h778CoVtOQzQHEq3TvIfgL3
	HUcdECrwmSbcBjeF5MDU8kxXCzGK1RJUBpsnCr7Nli5EG2uXiKtrYJFWlNX8CijUcEPkkd4xMe8
	5yX5efXb/8I6mxHh9OWsZuOIxqMxVatXFn+Y9Q+U5
X-Gm-Gg: AYBFou32IB88MnzEdVDpqFwzbw5V17N/RGxoyZf47yOm0+Wd8KKe0J1T4suPv2+vrdi
	kpGX0qY0LrW2Ae6fK6N+2gRc3/1b1y9HVpcdVwhzxuyyo/MtVLNi3Xqqt0Ekj53S++l+eX5FH8D
	K0IOrD5ceeYKwpZ1zg9xQt1cjtu0uzRuO3MJSxc3TI7Rm5u354d+tBaZ01fr/8cs9w9TUGWY3Uy
	ed+x/4SKpHBjvgrgcR8tbkokKs5qyTjtLa9NAMr3vgb5/IMnq6y8G1Bt0Gm7VtIt5E4qq1jBPdG
	tYFY/C1I950mpXAPyEz7FQnAkIzaqa0q76fNM4r/XOr97xexVg1EPdnb
X-Received: by 2002:a05:6402:5c3:b0:6ae:188e:e119 with SMTP id
 4fb4d7f45d1cf-6b32bb8e2e4mr1000a12.9.1792020711839; Wed, 14 Oct 2026 16:31:51
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-8-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-8-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 14 Oct 2026 16:31:39 -0700
X-Gm-Features: AclHuK9EHCeDUZdnrI67mbvozJY-igt-Nb7vmrmchnbUjAve2Tz2b0393hkSlgY
Message-ID: <CALMp9eR7u=oyfYPWuROMyW-2aOPDznTaHHjK8j+5=SCxaKbgFg@mail.gmail.com>
Subject: Re: [PATCH v3 07/27] KVM: SEV: Do ASID initialization at VMCB initialization
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> The per-vCPU ASID does not change for SEV guests, so move the per-vCPU
> (and per-VMCB) ASID initialization to sev_init_vmcb() to do it once,
> instead of setting it before every VMRUN.
>
> No functional change intended.
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
