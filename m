Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BF9370D4D
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535194; cv=pass; b=cBSncb1k+rfpWrlOzFuD8j8XHcc1oUoWwCufByVXwebWmpRTg5WyobVTbUk4E0AphJ3v51wWpouj6wLnBklvSADybnX2L7Zj+mSegibKFCn5RREOD+QctLgw43YyWie1Kjp6ojoONymPP9NLEoxcmgQKirmPhDzCNqXsnuJOFww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535194; c=relaxed/simple;
	bh=OUvbBts+AmfVJjAAqbTd6FzJIxojtNvdGMReKsNqD9c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nJ/vR57N7p934Ucw3EeUqQf/vNXihwykw6Pq0Z6PsE/0PwWXJdOyPjXgdKxYKU1psekhnwzrPwFrg70xGi6rbd/67MjXHjn+TFLahxAxxj7HLrpB9XyYRgipVNPREQm2XoPTya5yAVxxXAf+8Uy97Wj+kVqb98d9+NpdniTZMno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ow3Qj0Re; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ow3Qj0Re"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7de4ed0593fso2591232a34.1
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 14:33:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778535192; cv=none;
        d=google.com; s=arc-20240605;
        b=gjkOQnji1U0Gh1qaBWkco5UO6Gidvy+H42sVuG8nc2eDqYIwvLaZCl4dKqOxud7u0l
         /JrlfortyjwyElRJhV/U1WRj3C6GZxicQdV8s9LLoPxGAFBdFyt9Kv8WETjVqomTC9N+
         oeJxySIdvEty8Y/rxQ5wnZf4ZvQJWjnGSUqMLyhY7pHrpe5Q7DXCTQz6951ichT84JzE
         XDSiiGVXlHJAFsBaEUKYxfyg69rTweq/eH+cx8qa0qfdgyf1m7HWsdRiNQwmf21mb89b
         TBDm3oCMFkWCD2wmExRBhrYmi4xtTWBxnr3K7fY8zRaMfxHeAUR58zne1YOfxPe/GNpO
         pVzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=KesVZXgGayz8VlEfcs4ATjAvPhSFjzLMGZQiTnYubOA=;
        fh=y0SmQIcErd5uIgLUp6lUw+LKMxLd/CT36OS2lZdRUwo=;
        b=BJB/cMWw5hS3ZS2h+ESkD5sR5bQpy9B5F3+rkBwF2MVwdIFY1dVKPy0GsEIo9EIAmt
         5Id8wd35OivL964x9UgSYekBcGl44v8S0jStiCJru/dTeYEEQ0HNbV+tF9x38MhNFros
         pl/+HEUxdMCH22dAIyds3JRL9XveR1HGERwLHndMiXcA2R2CzPz9fxnXA+b7XwkXmXm1
         0c8uD6L/YuNl7kwcobQgzHuzgGkmnzuBnz7X/ggl9YdrBRdAJFfSv6szXl8Lo1s5qEVG
         oy6Pv7RsuV5e1fFcddmKB1TcgCPAt2KSHtsF5rrDrQJq7wght6gSN+VDeO4aHi3WVcYJ
         o/hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778535192; x=1779139992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KesVZXgGayz8VlEfcs4ATjAvPhSFjzLMGZQiTnYubOA=;
        b=ow3Qj0ReLPZvfDrutt24wWeVhO0rSFikqyUjVPUsubaaTKnjzU7Gb9XSwZ8zRolj+t
         4wUGXfSl1J8YhichHOxs58c3uFJ09qeAe1c/mfYv/XynHXtqJ+wWVnBv8/aSl1gcA1fl
         bTv3IUWU0JA0H2+ehxSY1k3L81L10VdYBtsNtXZJnpD++nCHsxbzDjjuN4IxLK7Rr6Lg
         W1bl2i5GJlD5K4LLeXoF9k4GWucOQ2Q+I92Q0iSkyjVzUXScDgL1u0nk+PBnn+/mHtaO
         rcroBj8fmMZPmD7NQ9hWiP1p4Jvv1ijfJST8MzSyCZT300JujHH5Fxf3O78dvXUx71Md
         B56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778535192; x=1779139992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KesVZXgGayz8VlEfcs4ATjAvPhSFjzLMGZQiTnYubOA=;
        b=iU1VyvGTiUmcEzLyAm6P3nds7m3GCOdRgOEdn1nTNRyIYpdGNOaFtgEaWrrqGUvC08
         TY2SazIjLuMq1Mbmd+diNb/P2nIsXVDAEWC6A3awV/17R8hqNnmEvWxpTyoivjtI1cq3
         yweEIY+9U55Gb0z6HTphIcLzjLFazvXZqPjYuRmkaqrQi0/0OgoDUpfUjMPUuLK9/fDM
         T+PULCU+LeWom8csT5/d7mm8Hv+DcWNd7ZCaRjA3Ujdi+dJWshf/11NqTpn2d0yApAeW
         tnNikYr4JyJZP4u89GCjhK6L3Sj104/vMKYC1G+lnfBfHFXkU82luHTS4DeTsXR5jnaq
         OlCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mfhwJYqnVrRewn+B+pL7d9F6Makrhyd5BZAVXh5HhMCQ+KGBPBevrzV+lTG1NujbJvH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo3VzdD8bGCkchPsgWfYHDgSdPOKRaGEbTufF5ODkhhy7LO7QY
	4XpmUeGP5sz24y1z63E42OL8vIpUbLDQW3YpDSaiqn8Mnm/q/L6ANubGutnKyfdRDI1zH4COn49
	36SK3DXpMJYKdhPRiGam/XdZEe5AOy9Q=
X-Gm-Gg: Acq92OH1lN0rTw9wn+zpxPIjaeQhMajo8NTmPRIfnoGLrtJoUkb5KayEJUTIzB8y3uA
	TOY7RR7RdUIt1/XQpxjgUnqfFDol+M7c+n1pVyfX+V5zkzQ/JQ8RNURNN2J4bIY0+2xzS9xmxAK
	xnVv/l4m5ANcHtvwbzf6Eop3IV/RGjp6smTkCGcawlXmnYuMKy3hHeE8kVHbzJm5u2fMGUciR+F
	jbNHr2cJ+CgLySveyOAcqrPb+xDrI1qmmIoGNeEkP+ZbMy5zpwQTG8d+4MiSFMjIP5lKsID8iRA
	8drlVKhLcv7Qdjv13JQnL1iE7Xtnf09tNEexww==
X-Received: by 2002:a05:6820:1994:b0:694:914a:ebe1 with SMTP id
 006d021491bc7-69b69e6237emr103335eaf.47.1778535192389; Mon, 11 May 2026
 14:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 11 May 2026 22:33:01 +0100
X-Gm-Features: AVHnY4JHrtR9s9ws_VGBViP50IT3XLP83fzAEzbiuHq0XPLX5_S0kPMDzhpKQpg
Message-ID: <CA+XhMqzcFRY=ogMhiCQeKqh-zz3RpP0nsUWYhP0jNhF9Uy+41A@mail.gmail.com>
Subject: [BUG] x86/virt/tdx: tdx_offline_cpu() violates tdx_cpu_flush_cache()
 preemption assert
To: Vishal Verma <vishal.l.verma@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

  In commit 597bdf6e068e ("x86/virt/tdx: Pull kexec cache flush logic into
  arch/x86"), tdx_offline_cpu() gained a call to tdx_cpu_flush_cache(),
  which starts with lockdep_assert_preemption_disabled().

  tdx_offline_cpu() is registered at CPUHP_AP_ONLINE_DYN. ONLINE-section
  teardown callbacks run from the pinned per-CPU hotplug thread with
  preemption and interrupts enabled (Documentation/core-api/cpu_hotplug.rst=
,
  and cpuhp_thread_fun() only disables IRQs for atomic states).

  The other callers =E2=80=94 tdx_shutdown_cpu() via on_each_cpu(), and the
  crash path =E2=80=94 satisfy the assertion. Only the offline path doesn't=
, and
  the splat should fire on every offline once the TDX module is
  initialized and the done: path is taken.

  Wrapping the call with preempt_disable() / preempt_enable() at the
  offline site keeps the contract for the kexec/shutdown callers.

  Not yet reproduced on a debug kernel; reporting on inspection.

  Fixes: 597bdf6e068e ("x86/virt/tdx: Pull kexec cache flush logic
into arch/x86")

  Cheers,
  David
