Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794240043;
	b=mcCSjgTF0vDcRtODLbl58lHd6nD+dH7p4Zz26LayWWb9vxhVcaWxxeTO++YO3Xg1UNHM
	 npsulBk0o64aMU9jRftKjjQ0uPTLbK1THxE7aOCHCgp5u1ebo8doxrClbQkVPeokDiKhH
	 3RkhGC+n0FWlynKoMMc9lz1lFlfNxpAZYZ7HWqcotcbg9kMaINBEM7O9vga702f6vnebT
	 aikgCaDf7j+AsEZgvyHmPGrIiDgkC3ZAgIpdhxulfG+J5TVUFCf9j0sJBMZCpvtQ9vEFx
	 nNhcOilHjVVRL1HLQJfrCjbOygA/RmmI5NcoGOXACYQd1EHkwTw99jLI5JAR/ZJMMig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=1IVvR7owaTCfwRNK1gEl9dRHd5D6+SPRltJMKFkI3Z4=;
	b=axr/mbZ+g4DAu5Z4dZtpbjtigyBs0SseqkWcs6uhDtzgXuFEe1KdEAioNQUvndSYzVEh
	 oMjsoSpqkrxoIVJROUKIOZ7O33k9JxZXz2XrjKkd8PgE4xk1mZ9PKj6lpxbkVKhCUguyW
	 VFV4RayNGKojVJNhNH2DSUHJ+k0+nWJwbi1OgCKNKUqoW+3t2TigkHq3phkhWBC1Dzdvr
	 xh/QxSNnr1QRoPq5W6a6aGv75IBqLy2rqt+T1GYhwKLBD4C/SQW+CIeJp9RWK0bREb6MK
	 s6bEWh+TlZXmE5nC1Jgcl9Nta8sM6vYlG4aRB7tT2Q85EJbHUUYY93czCSRCGvvodDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eVKMSmAw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA056606A331
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 16:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA056606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eVKMSmAw
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91ec396c93dso12257066d6.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 08:00:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794240042; cv=none;
        d=google.com; s=arc-20260327;
        b=J4Rmc0n4PDaniy0uhOLAn65pk6jI6lptDGTn3RNJhUviXQMiur9yLtE/J6huKfg82R
         j3Ai9w/fngWcMs1MnnxHQ3++kgFueQR42eEHmGSbmx5geJCUvEYb4u3wRdyAplOG3vMw
         iRNBfBkUK0NVm0En9UTZFNDJYmS4poG94blnkagwnGlTMRLv/I+jnAq5r9z+0VnY2cSU
         Q37dG/Z43eDqsW0BmcA3WY4w2vzudMWQti7Y0xNnHwiQ6j0flMExKpJshF/8+fPRhUZi
         RNPeyomtS+TilWzocr9NSwmAoiAMbijgpprpwDIwHMsn+l39cgT+M58+2Ka42DIpDHGW
         /QNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=1IVvR7owaTCfwRNK1gEl9dRHd5D6+SPRltJMKFkI3Z4=;
        fh=gYGzUeNpI8+ZyZe2AGDTS9+2Kmmej0pNRdFVFyTmpr8=;
        b=Ex8NIadjh1ZVKqQRkpp63bFd9hcMKv9ABHYO29754bGvVBfjJC+oY0L8boT9/uZHOa
         am5wmYNeJibhTvG3uJj3DWSNq3+2YRywCzkw1pmRALALyOzj/ea7xQzEJDkAIgDnEk4f
         C6TvEDo4/iCmP682uZWfCUxUukt8Y/a+Zs4HP2ulGHnyvMW9vOUf/TltO6LtCsSmBMwQ
         pIEj3DtFn2dcq9nAHvE/kcQPk05nxBdhU2pWjTJC1nqMgJOY+SUwOW9Nhu14ruQNg2eN
         CMj4/VEC0TpsCoSCLjKLRrqIyS5fZ+roI+XrXVobvI7wWP8mc77vmgFfCaX844H7WgoT
         So0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794240042; x=1794844842; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1IVvR7owaTCfwRNK1gEl9dRHd5D6+SPRltJMKFkI3Z4=;
        b=eVKMSmAwRDJ5fSeCORPgxCIKcy35/jStL56anO2mdaDeqKQUdUUrs7cHpaWXPuZrEe
         WjOcE/rFJJZDNtW8F5K7QKryfLTX9qxoE6LEGRTnqqKJhwB3SztHb1R2eVMupG+FZOKD
         sHQhKEJTm4xF3gxKt0PCmeqvGwDrZSCcl83RNoSyuGQXOvtLSuWD+rtxn/xMmCiBh8wl
         jqmJmZEGQxYee6qcqdzBIofbPAvCVKcaAD7DLmvkc9zIGZ0ND7pzzZOWCx4LszFh1ntA
         yUlfb8w9bELqfWFcod9ve/nX20GnAdXBKewbx7uv+Qcr5Usw+tWjXtqTnTge+NHNW8Lw
         nBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794240042; x=1794844842;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1IVvR7owaTCfwRNK1gEl9dRHd5D6+SPRltJMKFkI3Z4=;
        b=nQ0+9OwI/6vfWhjheEIp/JrekHfYcZhH+KtyswmbhYQzs4DB1bjinc3ZGvaUha6C3X
         fUerqEDtgv04kVvqbRWGI/oxdKk2VjX79DLcZozR+qX/FJ17V6+64Ba/NMyA/yCCD7J7
         6hRdmvm1LIuzAsuHyL36L1JVaRXJ4BWBqqUyADLafqeg34IaRbIZwza5ItO87RBFiahx
         v00lEj2+6TroAPCBvFhcwz7pNb8ai++wLyOJ/KzR6+2HNJNtng14vTaqqx4X9qQITimp
         ekvNtNEmW0BzVZ1cZ6CyR8Gy4KVBU2SYXy4GwdMkh9QOEvujRdUoKVaiWmqdpOlDfe/i
         8k/A==
X-Forwarded-Encrypted: i=1; AL+hErGTWPIsPI+H8xigZ5cs7xtL9IuQvJupYg37YVkLiOKZySzlrr0+RCtJvPZXq8bY0j6U7nw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nIYwatk00WnKyYdOEoSvucHHtksNvwF/RhTIgNjZdDWCsLL4q
	WJe4W2tO7Xszt7R8xfNBCYLXz6UPqxqN396jEGO+lr3LHv2jdcNh17Uu7ZrinYh0k6qcsHSiNY+
	qUTtKJaMIec+MlTYwV9Fv00vj3HkFsyLjITNU/U2p
X-Gm-Gg: AYBFou2qIVypLYcKMUWgH7USzans9JEGmdQuw/9QpZkQ/me/1j1kw7GYtPuGt2Tf3yS
	zbuPonUdifZ2Bsd9D4Js+afnU6+0dHz3Az30jX8AzsnfabjdceffzEYchC9M8rQh527Ik7/UOq1
	2zD92zZ3tdyjLPpUrdIR+HEi4WjVeeLwxgbbJjtzyvwwHz7yi79FxEvzohPzB0DdDy29mOctAsv
	+2222uNeiSV9dSPXy/irPEup2cEOWti8hb7W0sR+k5Egb0lNBl8ygTMboIvEfEDe9bHHFMPSyFo
	QgLVUkGsbgvQxWm47lfQVqc+Dzn+EFF0Nh2J/FrqI98AQCQvdPml/cpds6Yt7AsVBZogoJMlgpG
	rringz8c9v8Fu3FT5leSTdEmYHNe8yt5oSBA7F3NLEnfi4ipRUqf4AzUBfIOZpVG98g==
X-Received: by 2002:a05:6214:5402:b0:91e:ee31:55ba with SMTP id
 6a1803df08f44-91eef8c841emr97756d6.57.1794240035928; Mon, 09 Nov 2026
 08:00:35 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Nov 2026 08:00:34 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261105-tdx-selftests-v16-2-2024e8fa517a@google.com>
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com> <20261105-tdx-selftests-v16-2-2024e8fa517a@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 9 Nov 2026 08:00:34 -0800
X-Gm-Features: AclHuK8G0EZDW3tY7sTDlhlnaXZOXK3ScUEr2v83dxDnmQ6yymeVPIAKQ5tIQLE
Message-ID: <CAEvNRgHhzFxfXB+jXy+RCwTWevFTEW3RH4q51xztrFZYa4Xe_w@mail.gmail.com>
Subject: Re: [PATCH v16 02/20] KVM: selftests: Update kvm_init_vm_address_properties()
 for TDX
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"

Lisa Wang <wyihan@google.com> writes:

> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> Initialize the TDX S-bit and the GPA tag mask in
> kvm_init_vm_address_properties() for TDX VMs, similar to how the C-bit
> is initialized for SEV VMs.
>
> The TDX S-bit is used to distinguish between shared and private guest
> physical addresses. Its position is determined by the guest physical
> address width, which is either 48 or 52 bits for current TDX
> implementations.
>
> Co-developed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>
> [...snip...]
>
