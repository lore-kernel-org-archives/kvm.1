Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4624EFFD2
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286899; cv=none; b=s0+Y1nFt+EeIoe7fOsGC47GthPvJTCvD6OCKxIgdKYbiOrmQ94ClNcH+HpfQsDuOzWeiuYTtlr/kto/I0XOlExUiDoavVF6icWeCS2fznKi2iq52P87XlBrqm6J2XPAydH7wjnEUKbsCmvZP6N1lZ/7qGIkzDQi5HVIIBugqqC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286899; c=relaxed/simple;
	bh=kWppslkOvevKc9mXoahTnUM1fVIuXlqznuXN7nUb8rE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JXqBeQbVFbWcuRD0GW8sAYQXBOjvsqtiBLYNRZPbxc6u8NDgj4e5pR8GMCdhg63WtKbYR3UJ9dBEpBowYyByIooWAgH+VcZOHgYtwTRONYuhVcdJBX0w6MrDzpPcg/UgibxLntEG1B3EklpYVUPBFjhD3MYreBnEOZUHXrlOdKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kV6eBjNC; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kV6eBjNC"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2db3d832827so2087285ad.2
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 14:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790286898; x=1790891698; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2rfF6bxfqiDojUVP/uewObFMINnHxIN7q+IPmVtdXSU=;
        b=kV6eBjNCrVDVvk4GqsWLHVTSCujSoFEsjxW0fCEVYL64ZMtMRJqyMhR6otggikeDv4
         zwDN3sFPD6i68xFMfWgtoZ+4tk1GCHLHGII0AbqriR0jzizIxEnLLvtbi6xeEy3dci3C
         7B5I+Qsl3KoWVGrN3tZYkKqlCsvt2f+E+repxzq32Ws8v+NjIPoZT3N2bcbNiVmwv5DK
         GO9DOhaouZtqJElQagRMvmhuvPzRDPD7r9CJfrSBbLoq64Cj19SBiieUegxyxWBZwHue
         b6skFEKcpYQ29481B1CLvzeFniESBn6hZ3EaVQrqZ41BqpJ7u5lx7a9j++lJh+m/rfvp
         wYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286898; x=1790891698;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2rfF6bxfqiDojUVP/uewObFMINnHxIN7q+IPmVtdXSU=;
        b=1hp5jvF6qjIT0JcN3UQGFZjPmntD1pmtcsZh0dYUssnLARGhDaSbWMqrM++78rZigF
         4hrnvQswb32Y36JTXM4NzKN47WrynL7JNIFpnXU1E/t/yIbkG86u5RGF5KsxV1Gk1/KT
         /N/++2FH8jnskI9NVE4wYl2chmEncVE6nkrl9tF4ccRpRdcJ8nXoM04U7KACZcMMXc+y
         n4xd5MgBZwKCm1iyGHzsN507nu3lm2dMvyJjDBOxF+7h1j6DlCpcTSdp6IqUzTYQrEPc
         950ebPELPAeTbeIeOwu7bTBP45XdGctXDpPknp79BYula5Xv2ft6GBbq+OCnO/K0lORK
         bcKw==
X-Forwarded-Encrypted: i=1; AKwUvBy5C1zcycVh6AFiF1pREYTogW/TKgS4GqisLOZ6C5uxf/ptTPb74l6hqoE/y0l9vvn+YK0=@vger.kernel.org
X-Gm-Message-State: AFuF++n0Y6rA/SG8fhIr3aphHIZLguruM9aQOdbuhrfFCWW66EKBG5Mz
	dNqOv9QrYMSHss+uGYE1EVZwqDpgYAOl2I7FhuIlSuEuEeK6B9ylfQOEv3VSmOo6otBXGR3JXlZ
	sK78Qrw==
X-Received: from plas21.prod.google.com ([2002:a17:903:2015:b0:2df:9534:7dba])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:228b:b0:2df:90d4:1193
 with SMTP id d9443c01a7336-2df90d41a8cmr5867085ad.45.1790286897703; Thu, 24
 Sep 2026 14:54:57 -0700 (PDT)
Date: Thu, 24 Sep 2026 14:52:03 -0700
In-Reply-To: <20260921102442.1232375-1-zeng_chi911@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921102442.1232375-1-zeng_chi911@163.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179028359974.2001539.452762182755622284.b4-ty@b4>
Subject: Re: [PATCH v3] KVM: Don't treat reserved xarray entries as having
 memory attributes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, Zeng Chi <zeng_chi911@163.com>
Cc: chao.p.peng@linux.intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zengchi@kylinos.cn, 
	David Ballesteros <davimaba.v@proton.me>
Content-Type: text/plain; charset="utf-8"

On Mon, 21 Sep 2026 18:24:42 +0800, Zeng Chi wrote:
> kvm_vm_set_mem_attributes() reserves an xarray entry for every gfn in
> the range before storing the new attributes, so that the store loop
> can't fail partway through.  If one of the reservations fails, e.g. with
> -ENOMEM, the entries that were already reserved are left in the array.
> That is harmless as far as xa_reserve() is concerned, as the reserved
> entries read back as NULL via xa_load(), but it confuses the "does this
> range have no attributes at all" check:
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: Don't treat reserved xarray entries as having memory attributes
      https://github.com/kvm-x86/linux/commit/277d3623d99a

--
https://github.com/kvm-x86/linux/tree/next
