Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99E13B1008
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 21:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792101524; cv=pass; b=C08r72ESv+22oQo2WDhYN7OpHPD6nijtTYIUb7yRQdn3bxlgDqSkP/vZcBuM4lv0bX3YJf8n9OLBdjmE/UlSoiOFwsStWmYMfA7tRtDapJAoj7Vwdzkb/PKV8Q8SplCI7qMpJgl8vKzoqGfo+99zlqlsYc+Jn+JWjupfMLv8714=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792101524; c=relaxed/simple;
	bh=4lfsCC/pIXgqCBYAycCDNBM8TUqqtrJavSIaFKbNshw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLpapMCjR6YUOPhMsDFqIZ20pH6Gbcx20gxp9826LZ2q/FZ2Z3+MfnDrjzyRpfCUB3nCVUAtgStl5NqguX0aQl5Y4PHlgx2IquskUxD4j0pzmt/E3tjn8XH7v/XJA6vWPh5KLeXuqOGJIySuiYP2g8qOovOBzh5SWwyT4n+Fb5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fh1ySglX; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fh1ySglX"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so1632a12.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 14:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792101521; cv=none;
        d=google.com; s=arc-20260327;
        b=ak3yhJIrXmeQliLtqS91Y79pDgb6NqAU2v0NtbJXu2Pn4zz2FPlUJFCByU9BPlSsEh
         i5kAYA3mZQhTzXgzrOrYrK+Aju5OgnVtW9aujm6hnzKjwbjZz24xvshorEoXMRr50AoC
         CmKHHCqNBtch8efVmbkU367GNL/Dp2RhWGCRN0Qc2XN2ETdH8+a0AC1B9IcQWA7riDw1
         s5tQ5vDED1Jc+m+NCtIB5xsNI4SU97PnI8XgsN7NG9YDi8nBMyiiJgnLdFqb0wuzP+0b
         rOh017pcMQuahESrBW6Zuqi+4bgboakJnHCBIRuBjvCJzpKST9FmQeAx3qIKt7tyTQyq
         GznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4lfsCC/pIXgqCBYAycCDNBM8TUqqtrJavSIaFKbNshw=;
        fh=WZSpfSUxv/z0uSY77y0C3JbNIVDMdK1G4LBvapdPbE4=;
        b=qhaI3K2nK03z38iGviXJmShpPLUSiSBcZ1S+HQDgasU5dKfyMHAyj1+roFr3Cv8HKu
         hgrcdzSuZhCea8En/BRpSsMNLwAC56fySq3AkKwrP7+uA4/t9DXLeESGM4rcjexL9iaq
         XPK3t3JknRHYSLNbsFEBVwuNdnN12XTKN2AGpbUjAS/DNx5FelgJ2GWlBt3umOf3yoQX
         phqBOTqJYY6yNvXCxJTmFHyyAlSqVHa12OS1lIYK+UVW6henL61isv0Rr3Ju2z2nyX+A
         Z8y8cKoq4zfavTjo7RYUK3faMCpd1wnL+s9NJxMKxR+qWiD+ultdNGdUwBHjA3iz3YLY
         Pdsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792101521; x=1792706321; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4lfsCC/pIXgqCBYAycCDNBM8TUqqtrJavSIaFKbNshw=;
        b=Fh1ySglXl8hMK+ZtAwv2GwFacihlvCZzeVODdxh0ae4RT6sZCFc2x7FSaVakU2Q3ky
         KpR/QQGSCOub5djaEp2K3rxqWLzjB3KTW7+6J5j/fLQqsj/Bg+KMv25FYRFH3+kl0xmg
         5wijkuOChAjBt67/nk19zkeIglqRY2p2KL9QD4G2yD2JPFl0xJUAFn9eM/ktEKhxNtQb
         ENfV9s9OWVAq5SGDLb11x45SKD2OQmwtmk3fv6iCJhf3AZwQ90EWsZNgMh8w4l2yU6eY
         UBpDQOrd0NI2H9uorMiBbZSp6Bu+Qxha3Rg2RMZ304cKy/Mxj3zCsKIj/jfetfjnC5OQ
         yAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792101521; x=1792706321;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4lfsCC/pIXgqCBYAycCDNBM8TUqqtrJavSIaFKbNshw=;
        b=YrTil5G92vj/2b4lbI7EAMcxS6Ak5HzQASq6fAvWUlP5QfTEaMIozclkUptImTKUk/
         bSQCiY1JUsBBLOkaD2egxQ7x0jzE/NiuK6fU7bPIyQY0VaiJxBWlIlVNFLm1y2VEaFsX
         dT5GxlNGFwTDReR/M16XMtfq91PSVOJq5Ru1bA88MUJYM4H+O8Jc+Ar8fzjxdQ7nqfLK
         u5IY1F4Cvr8YXbcZAli6+TFBF9Hemqot3jZuMppBM0gvdh+ZWQKMNyvAUlOskJaf/hKH
         pWeinhoqOuJo1AalGhjINZ9U1UpxDUDtgMon71W/RBkohUIYbKaqI0RKMH22qdgAXq7t
         Yfqg==
X-Forwarded-Encrypted: i=1; AKwUvBwc4Ai17S7dPCc9MEfs5LMs06erBkpx2EwdOxNjdsx6d/2yLyWpQt4dn8h1F9R4gxOu1Bw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLv8UBTnSZquA7yhlhobIljDSLw1Iwnye86J9fc25bFAH3d2s45
	pDfOXLIxzpy/TCPM44ZwVEJjhNYDn5SUracXB8FC26n0Pg84C+WGmRuNGxBkVuJOV1tQanZFtiy
	lXuUFqIFA36AObrjCeCAet2T2E8epVGELQmDUxNjN
X-Gm-Gg: AYBFou09NfRLWGiEXhHZeGJm6LfP5Z2X2f2wwCc8o0qS/2JT2qSEiAsBSgn5ryud7p6
	+OzoldAoEkZIeZAxsYopXYtrJe6fwdZ40SAv4s9GYpl4pP62toamdGosmHl6gmVhK/Sa/7UbGys
	/GyIS5938Qo89OKjPzKRv7jXxMKiwnAKPf5gG9cNI8DAc+QYyPaKxQ3SFM9AzBpIekDCcxyYI0H
	g1AhMpPo4yOWoLb8BWSIiRIyrII05OSAhyHkyNCjmn7ccdCHNF9wmim1A0TpoG0g6YwbHhroYWU
	Z/uIyV4L3oJpdqxQr7WFxnQ2jOXnoDT3an9BtUqSEjS8RorJ8FBpELk=
X-Received: by 2002:a05:6402:208e:10b0:6b1:d80d:396b with SMTP id
 4fb4d7f45d1cf-6b375fddc3fmr77708a12.14.1792101520578; Thu, 15 Oct 2026
 14:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-15-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-15-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Oct 2026 14:58:26 -0700
X-Gm-Features: AclHuK9CxP6GbqbW9U7W79mpoa0Y4WMcsiBdKJF8JhPFOD_gck3RCkNZ1mCmaGU
Message-ID: <CALMp9eRLJcnUEwct80x5moBvomgxvLL8eiabx6=YXoHxLKsaRQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/27] KVM: x86: hyper-v: Rename kvm_hv_vcpu_purge_flush_tlb()
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Rename kvm_hv_vcpu_purge_flush_tlb() to kvm_hv_purge_tlb_flush_fifo() to
> clarify that it purges the TLB flush FIFO, not purge *and* flush the
> TLB.
>
> No functional change intended.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
