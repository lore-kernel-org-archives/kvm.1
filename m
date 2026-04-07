Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F4A3947A9;
	Tue,  7 Apr 2026 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564304; cv=none; b=T2tqnn7TnheYTkIEtuGj57oRkmk5X4mQC5M9Heh+8kaL4GUyjtcbPrOWsldotIIvkGDfnNSUlitLhP/qHj/yVJHej49ITvNh6krkyuIYlkPWgAbiIEvnTlbGs8IMYFTamakD/64j6HLy3u+yP7c5JWCxymVqCvveNEMidxRWBAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564304; c=relaxed/simple;
	bh=f7Yjr6zZGElM3Avdpb721u6AOmfOBlhIUGDuIzj6pKU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JO68ZRAiqpk5Ik6mBf4ruWC8tEDSSz/3DMpHMn6wEkaHKPJ2QB2fei5zMdo8USnxnteXJBW4oUL3Dflr+8flfy97AJXJEgy+1R9nlLnKDPvsw6hHOZByztUzJcXnxmCFi52Ifd4e19Hcyub+R1sSllSyWChWo40dmftDIPbHoNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 4A7A044188;
	Tue, 07 Apr 2026 14:18:20 +0200 (CEST)
Message-ID: <f40bc2d7-c02c-4dd6-a295-01f6d9b97805@proxmox.com>
Date: Tue, 7 Apr 2026 14:18:19 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/24] KVM: combined patchset for MBEC/GMET support
From: David Riley <d.riley@proxmox.com>
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Amit Shah <amit.shah@amd.com>, Sean Christopherson <seanjc@google.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
 <a7c32e69-afab-4289-95e3-330cc73f00d2@proxmox.com>
Content-Language: en-US
In-Reply-To: <a7c32e69-afab-4289-95e3-330cc73f00d2@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1775564233516

On 4/7/26 1:53 PM, David Riley wrote:
> [...]
> Results
>
> I compared the VM-Exit volume by running the workload with the feature
> flags (+vmx-mbec / +gmet) enabled vs. disabled. The table below shows
> the average number of samples (Total count of VM-Exit Events) over
> the 3 runs for each mode (idle/load).
>
> Platform  Mode  #Avg Exits Disabled  #Avg Exits Enabled  Reduction
> Intel          Idle          631722                   189460             70.01%
> Intel          Load   10020824                    775194     92.26%
> AMD         Idle          249200                    118042         52.63%
> AMD         Load        425217                    306945     27.81%
>
sorry for the broken formatting. The following should be better.

Platform  Mode  #Avg Exits Disabled  #Avg Exits Enabled  Reduction

Intel     Idle    631722             189460               70.01%
Intel     Load  10020824             775194               92.26%
AMD       Idle    249200             118042               52.63%
AMD       Load    425217             306945               27.81%

> Observations
>
> Intel MBEC:
> The reduction in VM-exits is massive (over 92% under load).
>
> AMD GMET:
> There is a measurable benefit (~28% reduction), though it appears less
> significant than the Intel results. However, it is worth noting that the
> AMD platform maintains a much lower baseline of VM-exits even with
> the feature disabled, suggesting more efficient native handling of
> these transitions compared to the Intel baseline in this specific test
> environment.
>
> On both architectures, I did not notice any stability issues with the
> patches applied.
>
> Let me know if there are more specific tests you're interested in.
>
> Tested-by: David Riley <d.riley@proxmox.com>
>
> [0] https://lore.kernel.org/qemu-devel/20260330193428.1663253-2-jon@nutanix.com/
> [1] https://learn.microsoft.com/en-us/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity?tabs=security
> [2]
>
> $Duration = 25
> $StopWatch = [System.Diagnostics.StopWatch]::StartNew()
>
> while($StopWatch.Elapsed.TotalSeconds -lt $Duration) {
>     for ($i = 0; $i -lt 100; $i++) {
>         $Value = Get-Random -Maximum 1000
>         $Code = [scriptblock]::Create("($Value * 2) / 2")
>         $Code.Invoke() | Out-Null
>     }
>     Start-Sleep -Milliseconds 20
> }
>
>
>
>

