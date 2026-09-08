Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B52E5A0ADA
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788894376; cv=pass; b=o0APyTO4KsLUi76G4Zr2mYLppEs7Sg6zyb7dopCauw4UIqtqY5jwUV1OlHzIMC3fuTN23vwWeZIGuNI3H1r15xse42TGR41BmXJ1l5SVSRdGYW413pAfH2e5WdZRrqSQN0yCBpb4ECg3plTIix8UdH4tP7W1nO03LofN9yh2J2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788894376; c=relaxed/simple;
	bh=JxAv9A35o8tRcwxKjZO94SBS9xDo9RgjGVk4mfstMJQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m082W5D3cqktyPubtPvZXQyzrqFkCD18Xq3I81wL0EM0i6G4oaweN0uCzg+9/orXNV6e2verZPDcqLfaTB7+QJhgapi+Qj1F+Q2umwn2IvckJB3lc47EL7O8ySzZtnuncgNh/zGUSVteWhwzjPBVaIRsJpO19UvKouG1CCMmwGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oC67sJca; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oC67sJca"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66fa10f35caso4567561d50.3
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 12:06:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788894374; cv=none;
        d=google.com; s=arc-20260327;
        b=Y7PHZ5jXlBQzCqbefZ9CAISFL55hs/JVbUOafiZkLoghqlliJftCtg0+fIH8kVOM2k
         cnmzsiNF+iqbOiGo7s/pOHzqMVqHUtx0/jQ4dXb51Kay5GimMQpAjP9vr2Fob+Mceomu
         1YBmSynzLkSt6Us8f0yXgRi1WTGIgP0mPA9DmYDqkLWJSNRHM4OQ+MV1lm7uu2vxHgd0
         vaXQgGit/EjkzC3qsru2iRRTJRWG91VwWXws2fy89MFQA4ZFYTSkeZwy6/8lqnMhU188
         SZAy8LTrmtcFnXd8+XHG3qYTNFeaSLMgf8Xe8VLAnv2fn79+hGdFB+A5yGgBDjSxPkm4
         p5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=hhSMn73HXnZUeqqhpj5wjt1oII0fZ8bLb8+fuULddR0=;
        fh=JmyTgRXjGy9m6FrbwtaCqzdfx9qWGmCGtdnd56JSY6I=;
        b=Pa8pFUSXtFcuJaNdSHCd6pMqNuKV5CjgLKuyJT936OFZeJpPtOa/yePUF13j3CNkoi
         MSGi4GV8F9Y+MPA5olZVgj7WJPV1YGe6bgAYJCeWy/W1ODmnSLP0fO0fvEN7qJr56eyC
         YRM08BrXWZSNo5a7XjwKSppo4xa35+sAcaH9Y2z8quo2ENQy5DzAn9ULOUsHwqBZlizk
         u7UlRX11htmyrjSJfywGRsQotNJ5xqXDMYn34yt3X/Qys8fwW0HEglHL15hf5j5uvk5O
         moQBo3riGSODBILVG1qja+5nzvRXikaXhWTDz1+z88U3RYHDniw0eqULak6UaMEeZFoq
         zpgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788894374; x=1789499174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hhSMn73HXnZUeqqhpj5wjt1oII0fZ8bLb8+fuULddR0=;
        b=oC67sJcaorDh1kjqjpVLuyalUhep2NkbBs6C69vF3ZQ737maXmCGNC9HR3wVUUAu+p
         IAPvdYi/hi9bOlyBUQWZuPxCac8/CSOfLY9V0PgProfNxs7AkRsoF/xQT1d7G1xlMbdq
         Va/ZeX03But8KMlDOphJyp+FtdcpWSI/61ioT5egU/rUM2n8wo1p/BPvkMicwzBTXcrl
         JOSAK3NFI/Mk3LQppqpEbN20vNgVLOk+xkmMx3+tOY3y4S64Cl2Uh7ZjiH1RT8yIRH8z
         XJgWT6NsQmdCVTkpjN1EdoCGffm0mte2KnEI61rF2cVh4AhUIIxfRGylQ+5hYMKyTbnH
         yb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788894374; x=1789499174;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hhSMn73HXnZUeqqhpj5wjt1oII0fZ8bLb8+fuULddR0=;
        b=Lk1JI21pBih47nAwVjug7rgo1lZoWT4Z8cqn91OnjNy3cSDjADwkDcEX10hfVBFM0z
         rgK37KE3A2rbJqzYFcpLx9LSFB9mFA0VUInXRPw/1yviGLTw73S4OR1Jzd7ktjqr9fB7
         SnNIgkao9M8LdkOuyFnvt9TgaK9xXj2+jQFF/whbd7TPJ2LQ/CpYDz2iy3uAfpZUliYX
         mNd+dVFnvaXQ1SbzXU+OozKzB6BEcU3+hP3NKkbOySD11m0QtA30yYmhRdQUTzpSIfYh
         YWgf5+wmmskHKJ99memBAD9mdW5JEn1TK9hAV3f0fJsqJlLeHZVkHdNXC512ZyqwsRqO
         x2PQ==
X-Gm-Message-State: AFuF++l8TF+bN8HluBlX/lV7MEZifSwYkbfVP6iD/7m2Cc4vuaptW6IP
	vee69MpOzkUesoCEGEueM1RHQ7y3CrL2SRu0oXkO5Q1DDSs0NU30SvEBMcOC5Yem+S5G6jkNNsK
	YlRtXv/+8KqnnNMUMwVjXRSuHsz36dhMvyFdJ+hV/
X-Gm-Gg: AYBFou24ulfDcZUy89+PaWXBulARUruIFvpQbAHKjDm+fF6uoYvIsNfjtwhLiYsEw0k
	L196bkW1dupH9DTu2qdzp08R/MPTY2Is0KHhUzKsblaP/NPWevxtNR5V3OR8+/bQbkhnCSw3j/3
	pMsxut6N8TSGGwml4eLpDhDUhjIIpzBhDub0yHGLJNyksoMWW5TDWoLuqeNivjM+U+DMg5io5n2
	P/LUYTC8/2xyMtc8YKPSyl12xnBJpuYGAmnk4h2IQSRKVTzgYEg56TNg1V/DsQF6wlqzWefpJ1y
	I2qairjIq2/c19tbBLSCKoomH9gFETI+HcIUebdZwwNSouoPI1OBpQwbiy/wnccJB3CvMxwgslT
	l+7tRzMX9yniVvFrdu+My9pBzqNEmRwC3i75GOaS9TA==
X-Received: by 2002:a05:690e:4143:b0:668:42d:95e5 with SMTP id
 956f58d0204a3-66fb58f1410mr10675130d50.4.1788894372039; Tue, 08 Sep 2026
 12:06:12 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 12:06:11 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 12:06:11 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ae783977c1eaa34d2910f76dac1437c7aad47d93.camel@intel.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-4-15ad654a50db@google.com> <ae783977c1eaa34d2910f76dac1437c7aad47d93.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Sep 2026 12:06:11 -0700
X-Gm-Features: AcwNN1XsGt_fUaARpEZcGvQCOF1lLG5Qg2IcdgK2WB2r0fv2QH8UPnIsl3MEqiA
Message-ID: <CAEvNRgHB9Vhwe4kOGYUn3piw3dw8zqSgVQX2VonoWCYPw-TaWA@mail.gmail.com>
Subject: Re: [PATCH v14 04/22] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES
 to validate TDs' attribute configuration
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "afranji@google.com" <afranji@google.com>, 
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"Chatre, Reinette" <reinette.chatre@intel.com>, 
	"isaku.yamahata@intel.com" <isaku.yamahata@intel.com>, "seanjc@google.com" <seanjc@google.com>, 
	"pratikrajesh.sampat@amd.com" <pratikrajesh.sampat@amd.com>, "oupton@kernel.org" <oupton@kernel.org>, 
	"wyihan@google.com" <wyihan@google.com>, "sagis@google.com" <sagis@google.com>, "Gao, Chao" <chao.gao@intel.com>, 
	"Wang, Roger" <runanwang@google.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "Qiang, Chenyi" <chenyi.qiang@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "jmcrey@google.com" <jmcrey@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> writes:

> On Wed, 2026-07-22 at 23:13 +0000, Lisa Wang wrote:
>> +static void tdx_check_attributes(struct kvm_vm *vm, u64 attributes)
>> +{
>> +	struct kvm_tdx_capabilities *tdx_cap;
>> +
>> +	tdx_cap =3D tdx_read_capabilities(vm);
>> +
>> +	/* Make sure all the attributes are reported as supported */
>> +	TEST_ASSERT_EQ(attributes & tdx_cap->supported_attrs, attributes);
>
> I think this patch actually does nothing because attributes is passed in =
as 0?
> So 0 & supported =3D=3D 0. It does exercise KVM_TDX_CAPABILITIES as claim=
ed, but so
> does tdx_filter_cpuid(). So for a minimal support, we could probably drop=
 this
> patch.
>

For more context, Isaku suggested this in [1], but after all the changes
tdx_read_capabilities() is already used in the tdx_init_vm() so I think
we're good to drop this patch.

[1] https://lore.kernel.org/all/20220901012853.GF2711697@ls.amr.corp.intel.=
com/
>> +}
>> +
>> =C2=A0void tdx_init_vm(struct kvm_vm *vm, u64 attributes)
>> =C2=A0{
>> =C2=A0	struct kvm_tdx_init_vm *init_vm;
>> @@ -112,6 +122,8 @@ void tdx_init_vm(struct kvm_vm *vm, u64 attributes)
>> =C2=A0	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
>> =C2=A0	free(cpuid);
>>
>> +	tdx_check_attributes(vm, attributes);
>> +
>> =C2=A0	init_vm->attributes =3D attributes;
>>
>> =C2=A0	tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);
