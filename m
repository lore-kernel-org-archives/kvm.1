Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822338;
	b=KbKXcdpCdVog0zpxFgmI6zQhxcWzbLHkmk2ci8+fLI4i+ykfIMLZvIDHedBGFj0E03qe
	 S+AAnmIFeE1YBh5p4DfZyGJ5q38ncYba+6e/TTNr/jsiBDWoyGrN9HMNn6UO7VKpdutyg
	 pJ7Zkd0oqTTMJ39qUpZxbp/OrIXTSaSrw9IiEnq/hFuwqYnXt1UheVAvTKxbjrNaGmHet
	 nDUUCYVsG54K64Sl7bGdajarzoMvd/XM8SOPq3cKqEhEdlTUGWYB7wgbzLHczzHEaIGNr
	 o+PkvmdY1pjTnYDK2pRT/V5Lqlyu429k/0yI/DP8OIeiAp3KfcQHRkI7tpcIDhOEwmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=EHk5yeUEIXC7UFrXwF/Qx/XTGMvkxGfWmAK/i22vALA=;
	b=JKAJABk5CVu8b1o4EKThWeIr33Fer5i6ThZpjOKqtiztx5lFOv+UW/B6O3M8kNt2/c1k
	 R0cKwOG4zY+l9PZr7GlpULGM/bDWrUIDCtnxZqLDbYBhVkV2WZo3+N9367HColXwbvpYN
	 SRSUqjawDT5cwse21X/cQ5R7PYfyTaCGW8AInOzITUgw3TnSSWZgHMfcgrauOyxIvRaik
	 jre7YY/3qgOKMNmmgJlWxEOLwiyvPh5dgFdWwtEAJYHWlqpfHngT+eTtHvXzIO98ijiTn
	 CoeKHodZpZeAh5LxjsLAjhn3r7LlSu2IAfS1aM6bdHZ1IYDIeHdzyUk8cdT6pdU/knQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P388IfTt;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220C2606D4D9
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 19:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 220C2606D4D9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P388IfTt
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3adc5b185bfso1226596a91.3
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 11:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793822337; x=1794427137; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EHk5yeUEIXC7UFrXwF/Qx/XTGMvkxGfWmAK/i22vALA=;
        b=P388IfTtlWm2shzuTrtWSPHnZifKhxpoiP7raetv2aDxaF7+9d6u7xEpTB5u7KEe/F
         fwFKjk7docwBVEMjxr63/85Asdm4EBZ1VNn+3e/Oxl6BityVcLbHDYuJXqf+xbklfuIA
         /VLyXTs/lMSSTCo4q8jig8etOM8OmGRhe8mAaJgz75CN+wL5XmM8BtQkdMdnqFY1QLhB
         cIDJpOxlpEvFPqynH01/IBQZEAFEDErzC8+jCKj9pfBzaNuynqe1VmjoCihrt2DcqPPa
         XFsM2d7gIaA8H4E3DMcq+1x6RgzSi6t540TuBV5bzvn0fJoOEk+3gCbGdt/v6ezH2LTn
         7wmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822337; x=1794427137;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EHk5yeUEIXC7UFrXwF/Qx/XTGMvkxGfWmAK/i22vALA=;
        b=W9nHDz4xCEiqJ3gEQ1tdmZ1wbdB5FGE3bJ16SQLaKrTjV+lEaQBEm+4cyxEADbjByr
         fXZ1rLVaFZmTHVfe1wVugpluikBDEU3NcoYJ6e/8CAQib/akJv622WCCyRud5VidYYNT
         VfRG0IhGExblrevzAV3yJR5Lz3W6rdgh6tZoHRf2F1jgJwW1EU16Nc5YE0sX+dV6tuAP
         h7vSy+eLFL+jBevpbAMC7SfLDU0nRWM8eqg9Uj7MLVxEos0124ImJ5upbILzgumz2e2I
         TgDX33W1s+R7CnD7aoyzjZx8TYSuUmFbGfJbmAC2LEFyCksdnosvMmVe1HG1RfjhPpwj
         EeDQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhB71EKPAxbmf+ieMeJetFRKuM9X35hTlrOzZn0iBJRFHgJ693TpZcKJkt8uV3Y58eP2o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FeF9/xPiTgREl4LbKh9a6eFTFTOK4agUdDBwM/hDYA/Jatbmm
	7F6wRBLBSDAzOl8nmk4YCBVYjnwpcjA5PUqyJyd7WbrKbA26P1fdVldme2GqYzmdZvaCyKAkdcx
	L9xLgCw==
X-Received: from pjwt8.prod.google.com ([2002:a17:90a:d148:b0:3ac:c43b:e307])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d803:b0:3b0:9a0d:b825
 with SMTP id 98e67ed59e1d1-3b09a0db95fmr1809747a91.45.1793822337303; Wed, 04
 Nov 2026 11:58:57 -0800 (PST)
Date: Wed, 4 Nov 2026 11:58:56 -0800
In-Reply-To: <atge--CosCmrOcx6@192.168.1.215>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <atge--CosCmrOcx6@192.168.1.215>
Message-ID: <auuOgNrHhlXSKDRV@google.com>
Subject: Re: [PATCH] KVM: x86: Emulate SYSENTER in 64-bit mode for
 Intel-compatible vCPUs
From: Sean Christopherson <seanjc@google.com>
To: Hao Zhang <hao_zhang_kdev@163.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 21, 2026, Hao Zhang wrote:
> From: Hao Zhang <zhanghao1@kylinos.cn>
> 
> Intel allows SYSENTER in both IA-32e submodes, whereas AMD raises #UD
> in either submode.  On AMD hosts, KVM intercepts #UD and emulates
> SYSENTER to support Intel-compatible vCPUs.
> 
> However, em_sysenter() unconditionally rejects execution from 64-bit
> mode.  As a result, a valid SYSENTER in an Intel-compatible guest can
> fail emulation instead of entering the guest's kernel.  For a
> non-nested guest at CPL0, this results in a
> KVM_INTERNAL_ERROR_EMULATION exit to userspace even when
> KVM_CAP_EXIT_ON_EMULATION_FAILURE is not enabled.
> 
> Remove the unconditional rejection.  

Why?  I'm not inclined to expand the emulator's capabilities for something like
this without a *really* good reason to do so.
