Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916EA412BF1
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231235; cv=none; b=j48KupRyJaS+i6k6vbpd11jORh1WtaQpz7koyFl+swtFWJM7OAA4PuQxQ9pxssdcBQO3d0QqsMHl0H1XXP9lYsD41fTlom206jMy4NfKbLudX8eQ96Qec7fbP3d5ab+mIJ59B/1cafxbFvaEXfX8PO7n5sxDQv4++NymkMJ8ifg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231235; c=relaxed/simple;
	bh=7tGBQCA2XLXhoKeC4mZgacirlxh2iFDs0WwkXpgnVtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMhmlGkXmNXiS1HAb39SdjztHdeYVo1ycrjHHDtVuV3APuXen9IOelMdliBPLGyEc83Mzbf/ZOH9AxCFb7hMyOPIq4aynst+wu4zybw0ucwTwLLgshxu4HrxOMM94Mk/qm33n19T68/w3SSVpTSm09Vub/KEdMOurYZlufyYtXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=rRS9DixD; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="rRS9DixD"
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66S9XooU092492
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 28 Jul 2026 18:33:50 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=EF1F5HBWUlmRu8oy4y9D6XUaw4jZ4ny8n1dqa1bBv5w=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1785231230; v=1;
        b=rRS9DixDkHf0C6uTIcC0kU6CMQI0rxOXvr3dRMoWyCpzNl9P29NsWn2u9HzPA6dc
         QzjiV4fJwP1Y5hf2PPpadhuNWwq39DUIECvEy+fQHsMfdmsI5ukLz1GjvW7Vz+qK
         qWtqtbGdxmWVhkneAheX2Kx+iOnUxmPhbCqLL0KOGZr8T906zRhbJjU7yLV1FRzR
         PSToNxvJ3sODetoeoKevwDvfW6PaK4J7UEPuf9qLltIpQXyzGb4RhSexSBCu+fXz
         NhFr7l5XnG21+wK74sizS5vDnVuYDxOcCxmpnIiRosulTuLXjaUACNQhT+ZgxaUB
         XxE+udRd8Znz5w3/So2X3g==
Message-ID: <39e270ed-1667-4bbf-8732-913e8b1f87e8@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 28 Jul 2026 18:33:49 +0900
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] target/arm: Always add pmu property for host and max
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
        qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
        devel@daynix.com
References: <20260629-pmu-v7-1-939518c349be@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA-=u3ZgiAXRNWM1VCMv7FYG2YP=oirf40yGo--p0BSfbg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAFEAcA-=u3ZgiAXRNWM1VCMv7FYG2YP=oirf40yGo--p0BSfbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/07/28 1:10, Peter Maydell wrote:
> On Mon, 29 Jun 2026 at 09:10, Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> kvm-steal-time and sve properties are added for KVM even if the
>> corresponding features are not available. Always add pmu property for
>> "host" and "max".
>>
>> Note that we still don't add the property for other CPUs that lack PMU.
>> This is because we do not know what a PMU version should be enabled
>> when the user sets the property to true while it is defined as an error
>> for the "host" or "max" CPU when the hardware accelerator is enabled and
>> the host doesn't have a PMU.
>>
>> This fixes qtest-aarch64/arm-cpu-features on the hosts that supports
>> KVM but doesn't support PMU emulation.
> 
> No, we should not special case "host" and "max" like this.
> The "pmu" property exists only if the CPU has a PMU and it can
> be turned off. If The arm-cpu-features test assumes that the
> host CPU always has a PMU and so always has the property, then
> that's a bug in the test, not in the code handling the property.

The test correctly avoids assuming that the host always has a PMU. It 
expects that the run-time-derived "host" CPU has a stable "pmu" 
property, with its value reporting whether PMU is available.

That is already how Arm handles SVE. Commit d25293068b03 ("target/arm: 
Move kvm test out of cpu_arm_set_sve") added a false SVE property when 
KVM lacks SVE. PAuth and kvm-steal-time use the same general model. 
Other architectures do the similar; for example LoongArch KVM does 
exactly this for "pmu". So we are avoiding special-casing the Arm pmu 
property here.

The comment in aarch64_add_sve_properties() gives the rationale 
explicitly: "to allow -cpu max,sve=off to always be valid." sve=on still 
fails in that case. Keeping the property stable prevents -cpu 
host,pmu=off from becoming invalid on hosts where the PMU cannot be 
enabled. This also matters outside the test: libvirt emits pmu=off when 
the PMU is explicitly disabled. This design is intended to follow the 
alternative you described previously [1].

"host" and "max" are special-cased for a different reason. For fixed Arm 
CPU models, the property is omitted because its semantics is not defined 
when they don't have PMUs. "host" and "max" are different: "host" and 
"max" enable whatever PMU available, and fail otherwise.

[1] 
https://lore.kernel.org/qemu-devel/CAFEAcA_HWfCU09NfZDf6EC=rpvHn148avySCztQ8PqPBMFx4_Q@mail.gmail.com/

Regards,
Akihiko Odaki
