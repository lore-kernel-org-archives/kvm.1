Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F339A4D8
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 22:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787956480; cv=pass; b=P6kX+uv0DZkEHYojKCYtJMi4t/hAaQIaHYPc2oEKmPd1UxHxCadasKaEdE3kHyR4q5C9GRwQ4R6knHhc0sr6BjtZSNm9h5yGH1UETEbe5BkqbTAYhcEvbClsVlxtEmKGsGVAL/E40JHaHLAAFZT4Q/W+2eOS1APS+YiXSsnGPCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787956480; c=relaxed/simple;
	bh=LsddL4PRlUTsAeoM7ovykaSIoHJp/TKPnksnw+b4W0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7EDAO/TjXCux/NMJRsqJGF5dmXYmG8DZGF+esVKQ5L4Iru5KpKmHYlZTCTozoQYfMjMlcwucH/giRj34bD5Wp9RSJ4LyHtHe1DeYDLUOKRjB5DiqKofvGr1Bd5YG4l02SYv/BRV7u2dXm6WHlWrpMiQyWsLwXp7AOHaB9JzasU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DVLCf++P; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DVLCf++P"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-52fac937235so42041cf.1
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 15:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787956478; cv=none;
        d=google.com; s=arc-20260327;
        b=pfeJxmjqApN7Camtt09BTlrG4AAj/RyMYUrquPRm1sgPT+9qbO5pxnjxDoBp/qEdl0
         5qup1C7O+KIn6ksxhoJi4Yzcn/Ja1dDL1dAdah6mLKc4Wu/GOC3Z+UpLmHGk0h59KAHm
         mZmmg7WH50gpP2bVNyBbdVaZdEhJJT76brNC2XU6FNeuff2j8DAeoIjbOYFQyBP+HHtf
         AR6CHi31J+7vDHPrRJKqQc7tM7AIzxNM2aNRNBf+T44gJnrhokicr8pz2VDEW9FbuI7y
         H2xKdJXNdvQ40Y8JXkxAItqjY8IZd2WYxucfbPiGMUTdnqqqSkdqQ+w/+dtXFkfU0eJU
         odcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cz3w4vC7ROKvyX2FGhFrH3o4RiUPpew0D579GCON3EU=;
        fh=5UmONQuZrV61tp/XiXIwYT16dN9GcXKRHHapjqQZIGQ=;
        b=Nz85r1w2pm2wCZwgu5OPBv5Jk1YAIBLorZSVK9WkgA3Di1KCiPuAMUdPJp5iTDOotv
         PzyiCiSWtDsy05wRFNBjqz3cRvwvJL1HFZ4gFoNTdWpEPTOfC3q8xhAP+hhnEYous8ie
         EdPJbCA5Uu9OsbRv2vDZRFh8gI9uQIZRhE383E32sH+4lDj34+kvdYGmMn64braPEAX+
         QonuZCIJJOO/9Z5uWV/+s/MK5Ryua/rCs41QYW4EqvYnEekjdmZZG84HwoVEdDLdU7la
         Hnu+ZbrO+sHpHH7mJKPqmn0H/zFCHfHXMlMW4TZUIYE18ERsyiGEVh+s9kHhg9Y8ode4
         CA/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787956478; x=1788561278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cz3w4vC7ROKvyX2FGhFrH3o4RiUPpew0D579GCON3EU=;
        b=DVLCf++PTc4ePRoNxkjNW7uu5fXBjVqgUxMXhWa9Gzwk961XDDCyCoQ1yJIL7xsHrf
         HFQZIzkk1jWm8SkEGD5hqobPB34AvGnFKSWyEA2Skn+yuhtOdCxCZTjBgstq/c7s3o3/
         v4furAvBYdnCCbQAy5HUfk19KY57h2eR0VVSK04FcPmjzrda9MWnxFP8bBEJtKREKh4N
         XFa4b3TUwmGzu6VZSexNafPKpZkzpY5QFxZhbNlePW4Ghrktb0KJ0iyORJhJIQGqvENU
         3lwffl6WQKlHFXoQOcuQWoFUZ/7YyxbCzOqn03k/hHNajPI6nYl4Lgdy2JAp6EM1DaTJ
         55qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787956478; x=1788561278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cz3w4vC7ROKvyX2FGhFrH3o4RiUPpew0D579GCON3EU=;
        b=AxsogxQ0sV3BSfibkj/0LiYrKzKSXITu0qFUdAkG571IOOTcCEAWrM1OqVz1usek+Q
         9738k/1qiniC6+toa6tU/P9UwAUdyD0/VohBhazl6IxEKga4L9TACd8GV5iXnQ3WdKmL
         bO7RwMK7EwwZEMFr2q3j40usxGnMHhhZvnCFwoTNh9l0bn7jbfpX3bjGKKHiHj67WIFG
         k8Jxfyo2QuxHUoFY/ljbmfT9qjD+I1iPK3L1ZcqXzd1h6dPX8fE2ppN8f/OrGOmPKfo4
         uHNFyjgkccGjjbogps5e3BfID0OamIZJlgUbMRBCmf3ra4ufFPqpNQ182Jz0H3fgr7lh
         rUjQ==
X-Forwarded-Encrypted: i=1; AHgh+RoqFZPwTd0v+8T3rBjRMSFtodg1DpwQ7VV6O7i3UAT4iWQvchdBiWwKGVUitKMGDanDXyk=@vger.kernel.org
X-Gm-Message-State: AFuF++kkVs+NYocvpZB1HtJ/9GibEaLnnWmE1aCGsVHNmwGAjSJlWdej
	KL71kC61hB4hT2xBcrMfG1+j1I5lynrgGyLllXqoDmIrP4jnvZyLDZ4EQarwcFfeaHI11bqHjZE
	tQa9mmgE03LgF+p48l+vmGEt0mqlYN+eP9rGDaJdr
X-Gm-Gg: AR+sD11WJzD1RmpfJF3fS9dLHgDgRDvY/30qNzwr/yVvplvPQSkG6umaSSC+8yy16k/
	HH9Cbt+/NDk4pSf52wRp3JuPMI9VRwQi1gPU8kfyXfBUiJu817t/KMYGq+POySNSBw+DNvNSRyC
	V0vOYgdfOwGE2x+JKpVIYLo2vN8qQXE/eECkyqzOkGliKI/q8nu/xspRMTcOjxL7gjgAeEm076e
	O0ZZhvQYqu4QkuAkomlskOgbfPOa0d1M6PTyVS02MAbGnkmwiFJ464f7b5nKLege06Dxm17a2tM
	7VWMRSCSFpZaWa57stegl9TwiZozPVmAP+eh6lm1IJdvKJoVQ4swQxBRF7qbelNSuZ0VDXOdfAo
	=
X-Received: by 2002:ac8:5d0d:0:b0:528:38d6:71b4 with SMTP id
 d75a77b69052e-52ff73ae215mr4559061cf.11.1787956477427; Fri, 28 Aug 2026
 15:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com> <20260806020850.1221381-9-rick.p.edgecombe@intel.com>
In-Reply-To: <20260806020850.1221381-9-rick.p.edgecombe@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 28 Aug 2026 15:34:26 -0700
X-Gm-Features: AcwNN1VVNzU9UspnZq9FN__NwaWjASBppoxqnYJM22b0AQZYrchahcz9KPBbKug
Message-ID: <CAGtprH8TceU0x4ivPk23jNGmhKBmJkhu=9YiHw2ibEJZ8gDhpg@mail.gmail.com>
Subject: Re: [PATCH v9 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, kas@kernel.org, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, nik.borisov@suse.com, 
	pbonzini@redhat.com, seanjc@google.com, tglx@kernel.org, x86@kernel.org, 
	chao.gao@intel.com, yan.y.zhao@intel.com, kai.huang@intel.com, 
	tony.lindgren@linux.intel.com, binbin.wu@intel.com, sohil.mehta@intel.com, 
	Hongyu Ning <hongyu.ning@linux.intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 7:09=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> Add Dynamic PAMT support to KVM's S-EPT MMU by "getting" a PAMT page when
> adding guest memory (PAGE.ADD or PAGE.AUG), and "putting" the page when
> removing guest memory (PAGE.REMOVE).
>
> To access the per-vCPU PAMT caches without plumbing @vcpu throughout the
> TDP MMU, begrudgingly use kvm_get_running_vcpu() to get the vCPU, and bug
> the VM if KVM attempts to set an S-EPT leaf without an active vCPU.  KVM
> only supports creating _new_ mappings in page (pre)fault paths, all of
> which require an active vCPU.
>
> The PAMT memory holds metadata for TDX protected memory. With Dynamic
> PAMT, PAMT_4K is allocated on demand. The kernel supplies the TDX module
> with a few pages that cover 2MB of host physical memory.
>
> Releases are balanced via tdx_pamt_put(): every control-page free goes
> through tdx_free_control_page(), and guest data pages are put directly on
> the successful tdh_mem_page_remove() path and in the
> tdx_mem_page_add/aug() error path.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [rick: enhance log, reviewing, rebase, with help from AI tooling]
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Acked-by: Sohil Mehta <sohil.mehta@intel.com>
> Acked-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Vishal Annapurve <vannapurve@google.com>
