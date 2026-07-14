Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A45E41A906
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054590; cv=none; b=H3S2+0/17gAaTXKmXjl/CFADRsa9od4El1+utF0V7HRzwpwx5Go98mJaI0NqLXrn/89vlZlF2118VxTZsO7h42ljdbAG5ZpSe8DxChsMi11QKVbL/32KjbrJygWujn8qsiGVfW4hMEj8EPMk5Y22Xhl1Ow8/SrJoo5f8uuFdBWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054590; c=relaxed/simple;
	bh=Y3nB/YWKgse6fE4CYr8dGPQclxUSNIMISmiDxbWmKWo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R5GZ7/yvX8z0w4y41C07gFtbWu9MyJGoRp7/ICFD2zKPlDzqqMOEnR3o7uctfIFtoWR9yy6NyYg0vYNdK0D1IGxPJOE2PdiIAO9WvmlECc+ikxGOZkuK0w91MtzG3OyYo8p9rv6wXvjgZERVz2s+9NMyEV4xYjSDWGDTfogZ9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QWXf1FZ+; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QWXf1FZ+"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84842381150so8249647b3a.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 11:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784054577; x=1784659377; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sgiWf1c5WxAndJDe6W3Ef5+DmyX9WQWvy7zVaNhvy+4=;
        b=QWXf1FZ+B3p2u2LNBXrfgwQ5gglqoRLbNzGa4ojNz1ywM27H2OCnq0zJgSvPOSVUVl
         rATQbIXi94frTuJo1uo/xEp1khcY+GHNPyuvpYx8+Pf22yvDE8Vc+Qd4KrCPpHZu8n6s
         Nt614CtKbJyFEsaB36ZC1o9yDrGRe8/sCV+dtit0gbfsKcjlbnfCMo5ack7XtH85du+P
         Jk/HZij6NVagTAvqyflOHsE8rwI928mvMVp4h+igJcc3srYNfHQ+pCM9ryzB8l3YNkNL
         Nzs/rxgo4mjppPI3P44SvNTM+MA3n4Rr3aQjjw2r4TJ3sP3WMOTc92qF8tkTiZcshoJ4
         ZWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054577; x=1784659377;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sgiWf1c5WxAndJDe6W3Ef5+DmyX9WQWvy7zVaNhvy+4=;
        b=MKgCicmtSF3i9YG2CraUBXyMqRM8FPCec4loRnKD3A8MgPMvcRJFIsw+djcXUV5bxe
         MueR88YjS50fm+ZbgTvPrbZU+1NZH3WZ9eBJWnmoyaslZ+no091CC+C0QLVPX+rmyUuh
         uNCeeFw8c6RCkkFqHbPJUH6PZ9pgEu3DGGEsJFVI+2at+Mvir3HIvRe4LsfQwkGXbxNp
         iMnTT+cWrAPsAoyvNNGniB6FKx8Fo6k/BwABXWfa9ILTZRYv0SdPwYj1mS299yXzAmM3
         ukvOgA2DYIho85i0wFhmwnIGWBWX+j4Fr3c3jNdLMaxiqVXfzohNR/8uDbUVmsZwoJ5k
         /M6w==
X-Forwarded-Encrypted: i=1; AHgh+RpT+pjBDON+sCcm7VFF7CHt80rns4pv6KBdWqDYYYITP/rKuEh+KEKvi5PJ5zgEtfGz0QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJpr59Y0zjN82VC1o/1rfTG3UwuemaCEg98j0HfJ+n+GhEvDXR
	Y1MLYtfVIM5lleqc83AB4UfDlfeZsGe+uBLwA2R+MThhqrYMoDdPAuw2vY4on2vWFtDLANWF07E
	Aij9+QQ==
X-Received: from pfx27.prod.google.com ([2002:a05:6a00:a45b:b0:848:5415:1869])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e01:b0:846:2f3c:3f66
 with SMTP id d2e1a72fcca58-84a5585047dmr3493128b3a.60.1784054576849; Tue, 14
 Jul 2026 11:42:56 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:03 -0700
In-Reply-To: <20260609075748.612704-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609075748.612704-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405421131.3138286.344633568989606466.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Fix emulated CPUID features being applied to
 wrong sub-leaf
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>
Cc: pbonzini@redhat.com, rick.p.edgecombe@intel.com, xiaoyao.li@intel.com, 
	chao.gao@intel.com, kai.huang@intel.com
Content-Type: text/plain; charset="utf-8"

On Tue, 09 Jun 2026 15:57:48 +0800, Binbin Wu wrote:
> Pass the CPUID index into cpuid_func_emulated() and return no emulated
> features for indexed CPUID leaves with a non-zero index.
> 
> KVM currently emulates CPUID features only for index 0, but
> kvm_vcpu_after_set_cpuid() looks up emulated features by function alone.
> As a result, reverse_cpuid[] entries that share a function but use a
> non-zero index, e.g. CPUID.7.1:ECX, can inherit emulated features that
> belong to index 0.  For example, RDPID, which is CPUID.7.0:ECX[22], can
> be incorrectly OR'd into CPUID.7.1:ECX.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Fix emulated CPUID features being applied to wrong sub-leaf
      https://github.com/kvm-x86/linux/commit/8835a24a5608

--
https://github.com/kvm-x86/linux/tree/next
