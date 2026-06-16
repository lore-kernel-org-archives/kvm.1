Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE2D394EA6
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 22:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781648728; cv=pass; b=SRaEY5S9Rwjtabx2hLHT6bDBz6MHEV5eVmVZN8lnDwpvsJb+tNb0gUFLZXZ8YZTllSo6tOAhHNO9nh0fV47MH3GbBvrPnYtQZqUenFWYls+q1T05UNwNeRd5vlK3qzAusHGoXx2tyI9KsPqR0wRqYHeEQG/jx7DWwlpAEI3Efks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781648728; c=relaxed/simple;
	bh=jKgvyKk7P9bNKSoGDvu/vOprsRoiXdKCkcTH/POdpsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWbCthu8DLbtfEIlHEsoQ8KHiIcicUe64RHSMS30rZAjHFAyT5EqgygzNvuWjrYMEYYps5X5k+SXsYDHfh/xF5Q+emb365WHYr6JPgaL2XDPfr5JUgXad2D4+sIRukfaywlFsawl98CC38+oG2t2K4K3UDCy9AjhCOHveuxthn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2utSYpf; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2utSYpf"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69565156c06so58a12.0
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 15:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781648725; cv=none;
        d=google.com; s=arc-20240605;
        b=R9Fptjcdk8w1yQZz2Hni2xYyH7BNWNBRX1mWxEDXNjc3HbzphTaBGpO7zb8MGRColI
         zFgv0ApBFRBiQoPOIxoVyvxPKqSAk6l0ylHJzuI50RaiC5OBGVF4a9+9vKHoroWfEYjp
         X6Ahnd8ipIKoXgKrm7vhI8fpiAiiKyB+j6c23Mqb+UrDTt3xXzNPeA66Mriw2RxdsEGR
         wnj5fqSs2v2cIwdEuh6ql6sdfu7Lxy1PBTUjssheQyihTgZfQFZoDUGET7w4hStkP7cT
         fi+EI1rvt4FN1+WLfYFTST4nI25rVwdVxaNatV55l6SJ0xD5gcc8xMkJqJHyQ3Zgqm93
         t7Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MV2HmtTBtTO8uZxXNcBM0C7QSI5cDV9ze8SL4kFOQSU=;
        fh=LV/yVWhv+FsoGtsLKzLed6AgXhIShoKNtEILeDkndAA=;
        b=dfQiYFfWDl3208BqJROMd2gwhxD9sCob8p/w7EeT96g+7Xzq8fH+OrEXyLhXqQbXXm
         nIN4QFyJENrgnUhZjWkq3e01FdAm9frDfrKUUVaFHtX0NjTW89xQeTkJaQA4YRduG0v9
         cRhmVo7L/Y1YJCPlCMZaSQV7GNNLUszyY0FrBsqgMxlBvWNkvCLxNfyqp8WHTqK7MJdo
         1hi0j+AoaMGc9c4JEXaGv+Vb9MCqjNMbbAnEepY2weBhDmjkj2X1JlaUi3hvnoX5eWmX
         AfpaE9+zeGqgjeqePOLy3QJnOT0Bq4cQxNkl+0ErxqHWyXBpIFHXeSuQHOhgz28wWt4Y
         FUvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781648725; x=1782253525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MV2HmtTBtTO8uZxXNcBM0C7QSI5cDV9ze8SL4kFOQSU=;
        b=e2utSYpfSuR3d2QIao9J1KDrBHAJtsE59G5p89sdZGExutjIx1WMXdfdkGBVhP4ahe
         +ImdluIKfy7lk1M3SteXG6h9Kt7Qd9iNAoCDBuI8GZf+1sAnYz7hSWsSeEeuOvbabV1i
         rP8MHOQ7QXkXNc8KSxdpzHmVnXl5EIST49+QaN98F616SqL3UKV5rxFxekSXQtQNMqX2
         kiNFgMK0rbHLs5kzwdIIP57JVo3uDqGsMwe2Xu8W7flUsGaLenmOVwilUozY4zEbAA7Z
         upyeNXDElcNgUpyr50cV33uD1A9dIzMTjh9snOWNRmYLaho1MBZ7xZa9zj/hlPFo8jxT
         C2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781648725; x=1782253525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MV2HmtTBtTO8uZxXNcBM0C7QSI5cDV9ze8SL4kFOQSU=;
        b=mP414P+J/MZhA9YJxaodYs9RJOb5pos8e6RAZOup98PcYdUyWEIzBSmJR4rUV0m/mg
         lydw3gfE3xgZK6/O8TQDmYQ6bdAntm5KKqTQ8frYCAWTvFmvR8rC5wOI8tH8+mscK4el
         wITu1AqswrucEL7Q4uCHBHNOi23iezPY82eqY4ZZovkbZdNA1eKEaL1AR8K2rPIIA6Wn
         fxFSCcM6MA4+xkHJaSl6aOgn6D1v/JP6xOTlNEC2KUa1oC5gWfQf1bhCYvXnc31PoaOZ
         oaex9XfnxMu7AiD3P+EYiK3+Ru1lrBgcHy3T135MSeMObE7YbPk33Q9Y3/q/FblVo/aZ
         xorQ==
X-Forwarded-Encrypted: i=1; AFNElJ9+y3n+zVYxLwRlazHvvRFGtvMk4SqKVZq7J28EgC+XQM9Augq6aAdTcqDsPpI2SvH0/yo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9hTR8+Uvi6VK1EZgGzcew9cZg0g9bJAUwpGR+Zh1P6JvzX94w
	js+NkKjr0vVIbp+LW9hBHwUZbDkutuChV/M/H6Y1wvdgtTwA1XmqySsBbnZC99DKNJ34mtkCNFw
	sGDF8d9mWSCbfx3IDReAVm42rliXPsn7sq7saKALheIc1OL7HqeivZj5+
X-Gm-Gg: Acq92OE4+SN2O1BJqosi41NKRKj1g8rwFBY0RA/wC6jM+g08qMpD7jmEpIVh5+L3Rgk
	n1gRQXVchRpq+oO1mYrsNQ6kzGTdxARlnpNjLPYkz8vMM4Fdl4rCTE10wsAV0Nr+/4H2EPEOqGM
	3PMQgH5P7hLOB0I2OlF+u8zrX711bi0xAfCrpKzlToKY9vqcqP2Mqys+xH5nReK04jUv+zVjCSP
	HWowfBdKByTPlfSAvB1JUv6oVPVs16NeKMIxsaZopeMgSqy+qAcKAehHzlFf3tXWcEZAnwz6JY4
	aEK5UdQ=
X-Received: by 2002:a05:6402:a244:20b0:672:117e:55d4 with SMTP id
 4fb4d7f45d1cf-695475741cdmr17062a12.0.1781648724795; Tue, 16 Jun 2026
 15:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616214652.2157032-1-yosry@kernel.org> <20260616214652.2157032-2-yosry@kernel.org>
In-Reply-To: <20260616214652.2157032-2-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 16 Jun 2026 15:25:12 -0700
X-Gm-Features: AVVi8CcXw57Fy4yvePc-el3RpLouLJgA5KfacL6pFCwGL-zOTuYKp6Sw3PIaXR8
Message-ID: <CALMp9eS0=dKsYvVwRpBy0dxv_Zn79L0UM6k+x7ezeiUTZdSzFQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: nVMX: Always flush vpid02 on first use
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 2:47=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Make sure vpid02 is always flushed on first use by setting last_vpid=3D0
> when allocating vpid02.  nested_vmx_transition_tlb_flush() will always
> detect a VPID change on first VM-Enter after VMXON, because VPID=3D0 in
> vmcb12 is not allowed if L1 enables VPID.
>
> This avoids using stale TLB entries from a previous lifetime of the
> VPID, that might have been associated with a different vCPU (or a
> completely different VM).
>
> Note that last_vpid is already being initialized as 0 when the vCPU is
> created, but it is not reset when vpid02 is freed on VMXOFF. Hence, the
> problem can only occur if L1 does VMXOFF -> VMXON, runs an L2, and KVM
> happens to reuse a VPID that has TLB entries on the physical CPU.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
Reviewed-by: Jim Mattson <jmattson@google.com>
